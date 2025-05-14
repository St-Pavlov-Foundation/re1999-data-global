module("modules.ugui.icon.IconMgrConfig", package.seeall)

local var_0_0 = _M

var_0_0.UrlItemIcon = "ui/viewres/common/item/commonitemicon.prefab"
var_0_0.UrlPropItemIcon = "ui/viewres/common/commonpropitem.prefab"
var_0_0.UrlEquipIcon = "ui/viewres/common/item/commonequipicon.prefab"
var_0_0.UrlHeroIcon = "ui/viewres/common/item/commonheroicon.prefab"
var_0_0.UrlHeroIconNew = "ui/viewres/common/item/commonheroiconnew.prefab"
var_0_0.UrlHeroItemNew = "ui/viewres/common/item/commonheroitemnew.prefab"
var_0_0.UrlPlayerIcon = "ui/viewres/common/item/commonplayericon.prefab"
var_0_0.UrlRedDotIcon = "ui/viewres/common/item/commonreddoticon.prefab"
var_0_0.UrlRoomGoodsItemIcon = "ui/viewres/room/roomgoodsitem.prefab"
var_0_0.UrlCommonTextMarkTop = "ui/viewres/common/item/commontextmarktop.prefab"
var_0_0.UrlCommonTextDotBottom = "ui/viewres/common/item/commontextdotbottom.prefab"
var_0_0.UrlHeadIcon = "ui/viewres/common/item/commonheadicon.prefab"
var_0_0.UrlCritterIcon = "ui/viewres/common/item/commoncrittericon.prefab"

function var_0_0.getPreloadList()
	return {
		var_0_0.UrlItemIcon,
		var_0_0.UrlPropItemIcon,
		var_0_0.UrlEquipIcon,
		var_0_0.UrlHeroIcon,
		var_0_0.UrlHeroIconNew,
		var_0_0.UrlHeroItemNew,
		var_0_0.UrlPlayerIcon,
		var_0_0.UrlRedDotIcon,
		var_0_0.UrlCommonTextMarkTop,
		var_0_0.UrlCommonTextDotBottom,
		var_0_0.UrlHeadIcon,
		var_0_0.UrlCritterIcon
	}
end

var_0_0.HeadIconType = {
	Static = 0,
	Dynamic = 1
}

return var_0_0
