//Import Modules
import { App } from "astal/gtk3"
import style from "./style.scss"
import bar from "./modules/bar/bar.tsx"
import osd from "./osd/osd"
import popups from "./notifications/popups"

//Main Config
App.start({
	css: style,
	instanceName: "js",
	requestHandler(request: any, res: (response: string) => void) {
		console.log(request);
		res("ok");
	},
	main: () => {
		App.get_monitors().map(bar);
		App.get_monitors.map(osd);
		App.get_monitors.map(popups);
	}
});
