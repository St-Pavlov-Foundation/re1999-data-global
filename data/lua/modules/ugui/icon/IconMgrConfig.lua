module("modules.ugui.icon.IconMgrConfig", package.seeall)

slot0 = _M
slot0.UrlItemIcon = "ui/viewres/common/item/commonitemicon.prefab"
slot0.UrlPropItemIcon = "ui/viewres/common/commonpropitem.prefab"
slot0.UrlEquipIcon = "ui/viewres/common/item/commonequipicon.prefab"
slot0.UrlHeroIcon = "ui/viewres/common/item/commonheroicon.prefab"
slot0.UrlHeroIconNew = "ui/viewres/common/item/commonheroiconnew.prefab"
slot0.UrlHeroItemNew = "ui/viewres/common/item/commonheroitemnew.prefab"
slot0.UrlPlayerIcon = "ui/viewres/common/item/commonplayericon.prefab"
slot0.UrlRedDotIcon = "ui/viewres/common/item/commonreddoticon.prefab"
slot0.UrlRoomGoodsItemIcon = "ui/viewres/room/roomgoodsitem.prefab"
slot0.UrlCommonTextMarkTop = "ui/viewres/common/item/commontextmarktop.prefab"
slot0.UrlCommonTextDotBottom = "ui/viewres/common/item/commontextdotbottom.prefab"
slot0.UrlHeadIcon = "ui/viewres/common/item/commonheadicon.prefab"
slot0.UrlCritterIcon = "ui/viewres/common/item/commoncrittericon.prefab"

function slot0.getPreloadList()
	return {
		uv0.UrlItemIcon,
		uv0.UrlPropItemIcon,
		uv0.UrlEquipIcon,
		uv0.UrlHeroIcon,
		uv0.UrlHeroIconNew,
		uv0.UrlHeroItemNew,
		uv0.UrlPlayerIcon,
		uv0.UrlRedDotIcon,
		uv0.UrlCommonTextMarkTop,
		uv0.UrlCommonTextDotBottom,
		uv0.UrlHeadIcon,
		uv0.UrlCritterIcon
	}
end

slot0.HeadIconType = {
	Static = 0,
	Dynamic = 1
}

return slot0
