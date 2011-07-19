package org.purugin;

import java.io.FileNotFoundException;
import org.bukkit.plugin.java.JavaPlugin;

import com.avaje.ebean.EbeanServer;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import org.jruby.embed.ScriptingContainer;

public final class PuruginPlugin extends JavaPlugin {
    private static String MAIN = "/purugin.rb";
    private ScriptingContainer container = new ScriptingContainer();
    private Object main = null;
    
    @Override
    public void onDisable() {
        // FIXME: We seem to now get two instances of PuruginPlugin and I don't know why yet...
        if (main != null) {
            container.callMethod(main, "onDisable");
        }
    }

    @Override
    public void onEnable() {
        // FIXME: We seem to now get two instances of PuruginPlugin and I don't know why yet...
        if (main != null) {
            container.callMethod(main, "onEnable");
        } 
    }

    @Override
    public void onLoad() {
        Object brainsClass = executeScript(getClass().getResourceAsStream(MAIN), MAIN);
        main = container.callMethod(brainsClass, "new", this, getPluginLoader());
        getServer().getPluginManager().registerInterface(RubyPluginLoader.class);
        container.callMethod(main, "onLoad");
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
