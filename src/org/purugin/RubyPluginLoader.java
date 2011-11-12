package org.purugin;

import java.io.File;
import java.util.regex.Pattern;
import org.bukkit.Server;
import org.bukkit.event.Event;
import org.bukkit.event.Listener;
import org.bukkit.event.server.PluginEnableEvent;
import org.bukkit.event.server.PluginDisableEvent;
import org.bukkit.plugin.EventExecutor;
import org.bukkit.plugin.InvalidDescriptionException;
import org.bukkit.plugin.InvalidPluginException;
import org.bukkit.plugin.Plugin;
import org.bukkit.plugin.PluginLoader;
import org.jruby.embed.ScriptingContainer;

public class RubyPluginLoader implements PluginLoader {
    private static final Pattern[] rbRegexp = new Pattern[] { Pattern.compile("\\.rb$") };
    private Server server;
    private PuruginPlugin master;
    
    public RubyPluginLoader(Server server) {
        this.server = server;
        master = (PuruginPlugin) server.getPluginManager().getPlugin("PuruginPlugin");
        master.getContainer().callMethod(master.getMain(), "ruby_plugin_loader=", this);
    }
    
    
    @Override
    public Plugin loadPlugin(File file, boolean ignoreSoftDependencies) 
            throws InvalidPluginException, InvalidDescriptionException {
        ScriptingContainer container = master.getContainer();
        String path = file.getAbsolutePath();

        master.executeScriptAt(path);

        return (Plugin) container.callMethod(master.getMain(), "instantiate_plugin", path);
    }
    
    @Override
    public Plugin loadPlugin(File file) throws InvalidPluginException, InvalidDescriptionException {
        return loadPlugin(file, false);
    }
    
    @Override
    public Pattern[] getPluginFileFilters() {
        return rbRegexp;
    }

    @Override
    public EventExecutor createExecutor(final Event.Type type, Listener listener) {
        // Use master to create this since this is a shitload of code...
        return master.getPluginLoader().createExecutor(type, listener) ;
    }    
    
    @Override
    public void enablePlugin(Plugin plugin) {
        server.getPluginManager().callEvent(new PluginEnableEvent(plugin));
        plugin.onEnable();
    }

    @Override
    public void disablePlugin(Plugin plugin) {
        server.getPluginManager().callEvent(new PluginDisableEvent(plugin));
        plugin.onDisable();
    }
}
