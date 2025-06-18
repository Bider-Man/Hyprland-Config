---- Keymaps ----
local keymap = vim.keymap

---- General Keymaps ----
keymap.set("n", "<leader>nh", ":nohl<CR>", {desc = "Clear search highlights"})
keymap.set("n", "x", '"_x')
keymap.set("n", "<leader>+", "<C-a>", {desc = "Increment number"})
keymap.set("n", "<leader>-", "<C-x>", {desc = "Decrement number"})
keymap.set("n", "<leader>sv", "<C-w>v", {desc = "Split window vertically"})
keymap.set("n", "<leader>sh", "<C-w>s", {desc = "Split window horizontally"})
keymap.set("n", "<leader>se", "<C-w>=", {desc = "Makes splits equal"})
keymap.set("n", "<leader>sx", ":close<CR>", {desc = "Close current split"})
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

---- Tab Management ----
keymap.set("n", "<leader>to", ":tabnew<CR>", {desc = "Open new tab"})
keymap.set("n", "<leader>tx", ":tabclose<CR>", {desc = "Close current tab"})
keymap.set("n", "<leader>tn", ":tabn<CR>", {desc = "Go to next tab"})
keymap.set("n", "<leader>tp", ":tabp<CR>", {desc = "Go to previous tab"})

