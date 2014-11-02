package org.purugin;

import cpw.mods.fml.common.Mod;
import cpw.mods.fml.common.SidedProxy;
import cpw.mods.fml.common.event.FMLInitializationEvent;
import cpw.mods.fml.common.event.FMLPostInitializationEvent;
import cpw.mods.fml.common.event.FMLPreInitializationEvent;
import cpw.mods.fml.common.event.FMLServerStartingEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLDecoder;
import net.minecraft.server.MinecraftServer;
import org.jruby.embed.ScriptingContainer;

@Mod(modid=ModInfo.ID, name=ModInfo.NAME, version=ModInfo.VERSION)
public class PuruginMod {
    private static String MAIN = "/purugin.rb";

    @Mod.Instance(value = "GenericModID")
    public static PuruginMod instance;

    private MinecraftServer server = null; // Populated after serverStartingEvent.

    private ScriptingContainer container = new ScriptingContainer();

    private Object main = null;

    // Says where the client and server 'proxy' code is loaded.
    @SidedProxy(clientSide=ModInfo.CLIENT_PROXY, serverSide=ModInfo.COMMON_PROXY)
    public static CommonProxy proxy;

    @Mod.EventHandler
    public void preInit(FMLPreInitializationEvent event) {
        // Stub Method
    }

    @Mod.EventHandler
    public void serverStarting(FMLServerStartingEvent event) {
        server = event.getServer();

        try {
            System.out.println("Purugin: serverStarting");
            container.setClassLoader(PuruginMod.class.getClassLoader());
            URL url = getClass().getResource(MAIN);
            System.out.println("Purugin: url is " + url);
            String unescapedURL = URLDecoder.decode(url.toString(), "UTF-8");
            System.out.println("Purugin: unescaped url is " + unescapedURL);
            Object brainsClass = executeScript(url.openStream(), unescapedURL);
            System.out.println("Purugin: brains class is " + brainsClass);
            main = container.callMethod(brainsClass, "new", this, "C:/opt/purugin/plugins");
            System.out.println("Purugin: main instance is " + main);
        } catch (IOException e) {
            System.out.println("Purugin: Cannot openStream (this should be impossible)");
        }
    }

    @Mod.EventHandler
    public void load(FMLInitializationEvent event) {
        proxy.registerRenderers();
    }

    @Mod.EventHandler
    public void postInit(FMLPostInitializationEvent event) {
        // Stub Method
    }


    protected Object executeScript(InputStream io, String path) {
        try {
            return container.runScriptlet(io, path);
        } finally {
            try { if (io != null) io.close(); } catch (IOException e) {}
        }
    }

    protected Object executeScriptAt(String path) {
        try {
            return executeScript(new FileInputStream(new File(path)), path);
        } catch (FileNotFoundException ex) {}

        return null;
    }

    public MinecraftServer getServer() {
        return server;
    }
}
