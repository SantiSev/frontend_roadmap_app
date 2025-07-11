import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'
import tailwindcss from '@tailwindcss/vite'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react(),
    tailwindcss(),
  ],
  server:{
    host: true,
    strictPort: true,
    port: 8080,
    watch: {
      usePolling: true,
  }
},
  build: {
    minify: true,
    rollupOptions: {
      onwarn(warning, warn) {
        if (warning.code === 'TS_ERROR') return
        warn(warning)
      }
    }
  }
})
