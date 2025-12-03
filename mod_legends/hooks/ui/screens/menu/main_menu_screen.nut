::mods_hookExactClass("ui/screens/menu/main_menu_screen", function(o) {

	o.connect = function ()
	{
		this.m.JSHandle = this.UI.connect("MainMenuScreen", this);
		this.m.MainMenuModule.connectUI(this.m.JSHandle);
		this.m.LoadCampaignModule.connectUI(this.m.JSHandle);
		this.m.NewCampaignModule.connectUI(this.m.JSHandle);
		this.m.ScenarioMenuModule.connectUI(this.m.JSHandle);
		this.m.OptionsMenuModule.connectUI(this.m.JSHandle);
		this.m.CreditsModule.connectUI(this.m.JSHandle);
		this.m.JSHandle.asyncCall("setVersion", [this.GameInfo.getVersionNumber() + " " + this.GameInfo.getVersionName(), "Legends Mod " + ::Legends.Version + " " + ::Legends.BuildName]);
local dlc = [];

		for( local i = 0; i < 32; i = ++i )
		{
			if (this.Const.DLC.Info[i] != null && this.Const.DLC.Info[i].Announce == true)
			{
				local hasDLC = (this.Const.DLC.Mask & 1 << i) != 0;
				dlc.push({
					Image = hasDLC ? this.Const.DLC.Info[i].Icon : this.Const.DLC.Info[i].IconDisabled,
					Tooltip = "dlc_" + i,
					URL = this.Const.DLC.Info[i].URL
				});
			}
		}


		this.m.JSHandle.asyncCall("setDLC", dlc);
local missingFiles = this.checkForRequiredFiles();
local test = false;
if (!this.Const.DLC.Unhold || !this.Const.DLC.Wildmen || !this.Const.DLC.Desert || missingFiles.len() > 0)
{
local disabledMotdText = "Отсутствуют критически важные файлы!";
if (!this.Const.DLC.Unhold || !this.Const.DLC.Wildmen || !this.Const.DLC.Desert) disabledMotdText += "\nLegends активно использует возможности и ресурсы всех официальных DLC. Мы не смогли бы дать вам этот опыт без потрясающей работы Overhype.";
if(!this.Const.DLC.Unhold) disabledMotdText += "\nОтсутствует DLC ‘Beasts and Exploration’";
if(!this.Const.DLC.Wildmen) disabledMotdText += "\nОтсутствует DLC ‘Warriors of the North’";
if(!this.Const.DLC.Desert) disabledMotdText += "\nОтсутствует DLC ‘Blazing Deserts’";
if(missingFiles.len() > 0) {
foreach (fileType, fileName in missingFiles){
disabledMotdText += format("\nОтсутствует %s файл %s", fileType, fileName);
}
}
this.m.JSHandle.asyncCall("setLMOTD", disabledMotdText);
} else {
this.m.JSHandle.asyncCall("setMOTD", "Добро пожаловать в Legends.\n\nЧтобы сообщить об ошибках, поделиться стратегиями и идеями или попробовать тестовые сборки, заходите к нам: https://discord.gg/ZfCHGuC");
}
	}

	o.checkForRequiredFiles <- function (){
		local missing = {};
		// local requiredFiles = this.Const.LegendMod.RequiredFiles;
		// local filesInData = this.IO.enumerateFiles("");
		// foreach (fileType, fileName in requiredFiles){
		// 	if(fileName != "" && filesInData.find(fileName) == null){
		// 		missing[fileType] <- fileName;
		// 	}
		// }
		return missing
	}

	o.show = function ( _animate )
	{
		if (this.m.JSHandle != null && !this.isVisible())
		{
			this.Tooltip.hide();

			if (!this.Const.DLC.Unhold && !this.Const.DLC.Wildmen && !this.Const.DLC.Wildmen)
			{
				this.m.JSHandle.asyncCall("noshow", null);
			}
			else
			{
				this.m.JSHandle.asyncCall("show", _animate);
			}
		}
	}
});
