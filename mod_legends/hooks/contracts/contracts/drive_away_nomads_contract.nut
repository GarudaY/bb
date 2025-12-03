::mods_hookExactClass("contracts/contracts/drive_away_nomads_contract", function(o)
{
	local create = o.create;
o.create = function()
{
create();
this.m.Name = "Песчаные налётчики";
this.m.DescriptionTemplates = [
"Ночлег кочевников устроен недалеко от дорог к %s. Изворотливые и неуловимые, пустынные племена ходят тут веками.",
"Жизнь среди песчаных кочевников — бесконечный путь под палящим солнцем. Помогите им продолжить этот путь в другом месте.",
"Среди дюн песчаные кочевники выживают благодаря стойкости и умению приспосабливаться. Не стоит их недооценивать.",
"Родство и традиции — основа общества песчаных кочевников. Звучит мило, но вы видели, что они творят с безоружными торговцами на дорогах.",
"Песчаные кочевники бьют молниеносно, оставляя после набегов лишь пыль и отчаяние.",
"Кочевники рыщут в пустыне вокруг %s, их налёты — постоянная угроза всем, кто осмеливается пройти по пескам.",
];
}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(this.m.Home.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}
});
