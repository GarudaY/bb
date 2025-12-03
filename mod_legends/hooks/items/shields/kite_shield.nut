::mods_hookExactClass("items/shields/kite_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3,4,5,6,7,8,9,10,11];
		this.addVariants();
		this.m.Variant = this.Math.rand(0, 9); //random one is only 1-9 though
	}

	o.addVariants <- function()
	{
		this.m.Variants = [];
		local bannerID = 0;
		foreach (banner in ::Const.PlayerBanners)
		{
			bannerID = banner.slice("banner_".len()).tointeger();
			bannerID = bannerID < 50 ? bannerID + 11 : bannerID;
			this.m.Variants.push(bannerID);
		}
	}

	o.onPaintSpecificColor <- function ( _color )
	{
		this.setVariant(_color);
		this.updateAppearance();
	}

	o.onPaintInCompanyColors = function ()
	{
		local bannerID = this.World.Assets.getBannerID() >= 50 ? this.World.Assets.getBannerID() : this.World.Assets.getBannerID() + 11;
		this.setVariant(bannerID);
		this.updateAppearance();
	}
});
