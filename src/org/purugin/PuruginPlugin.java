package org.purugin;

import java.io.FileNotFoundException;
import org.bukkit.plugin.java.JavaPlugin;

import com.avaje.ebean.EbeanServer;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import org.jruby.embed.ScriptingContainer;

public final class PuruginPlugin extends JavaPlugin {
    private static String MAIN = "/purugin.rb";
    private ScriptingContainer container = new ScriptingContainer();
    private Object main = null;
    
    @Override
    public void onDisable() {
        container.callMethod(main, "onDisable");
    }

    @Override
    public void onEnable() {
        container.callMethod(main, "onEnable");
    }

    @Override
    public void onLoad() {
        try {
            URL url = getClass().getResource(MAIN);

            Object brainsClass = executeScript(url.openStream(), url.toString());
            String path = getConfiguration().getString("path", "plugins");
            main = container.callMethod(brainsClass, "new", this, getPluginLoader(), path);
            getServer().getPluginManager().registerInterface(RubyPluginLoader.class);
            container.callMethod(main, "onLoad");
        } catch (IOException e) {
            System.out.println("Error: Cannot openStream (this should be impossible)");
        }
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
    
    protected ScriptingContainer getContainer() {
        return container;
    }
    
    protected Object getMain() {
        return main;
    }

    @Override
    public EbeanServer getDatabase() {
        return null;
    }
}
