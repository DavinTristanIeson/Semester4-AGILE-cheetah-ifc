import { fileURLToPath, URL } from 'node:url'
import { join, parse, resolve } from "path";

import { defineConfig, type PluginOption } from 'vite'
import vue from '@vitejs/plugin-vue'

const devServerFallbackPlugin:PluginOption = {
  name: "dev-server-fallback-plugin",
  configureServer(server){
    const targets = ["index", "admin"];
    server.middlewares.use((req, res, next)=>{
      if (!req.url) next();
      if (req.url == '/'){
        req.url = "/index.html";
      } else if (targets.find(x=>req.url?.endsWith(x))){
        req.url += ".html";
      }
      next();
    });
  }
}


function entryPoints(...paths: string[]) {
  // https://stackoverflow.com/questions/70198637/base-url-with-multi-page-apps-using-vite
  const entries = paths.map(parse).map(entry => {
    const { dir, base, name, ext } = entry;
    const key = join(dir, name);
    const path = resolve(__dirname, dir, base);
    return [key, path];
  });
  
  const config = Object.fromEntries(entries);
  return config;
}


// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(), devServerFallbackPlugin],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  build: {
    rollupOptions: {
      input: entryPoints(
        "./admin.html",
        "./index.html",
      )
    }
  }
});
