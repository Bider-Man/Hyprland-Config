import { App } from "astal/gtk3"

export function setupHyprland() {
  // Initialize workspace tracking
  Utils.execAsync('hyprctl monitors -j').catch(console.error)
  
  // Example event listener
  App.connect('window-toggled', (_, name) => {
    if (name === 'hyprland') {
      // Handle Hyprland events
    }
  })
}
