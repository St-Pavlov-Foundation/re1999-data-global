module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiUnitTipItem", package.seeall)

slot0 = class("WuErLiXiUnitTipItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txtname = gohelper.findChildText(slot1, "txt_desc/image_bg/txt_namecn")
	slot0._txtdesc = gohelper.findChildText(slot1, "txt_desc")
	slot0._gonormalicon = gohelper.findChild(slot1, "Icon")
	slot0._imageiconbg = gohelper.findChildImage(slot1, "Icon/image_IconBG")
	slot0._imageicon = gohelper.findChildImage(slot1, "Icon/image_icon")
	slot0._golongicon = gohelper.findChild(slot1, "Icon_long")
end

function slot0.setItem(slot0, slot1)
	gohelper.setActive(slot0.go, true)

	slot0._config = slot1
	slot0._txtname.text = slot0._config.name
	slot0._txtdesc.text = slot0._config.desc

	gohelper.setActive(slot0._golongicon, slot0._config.id == WuErLiXiEnum.UnitType.SignalMulti)
	gohelper.setActive(slot0._gonormalicon, slot0._config.id ~= WuErLiXiEnum.UnitType.SignalMulti)

	if slot0._config.id ~= WuErLiXiEnum.UnitType.SignalMulti then
		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageicon, WuErLiXiHelper.getUnitSpriteName(slot0._config.id, false))

		slot3 = "v2a4_wuerlixi_node_icon2"

		if slot0._config.id == WuErLiXiEnum.UnitType.SignalStart or slot0._config.id == WuErLiXiEnum.UnitType.SignalEnd then
			slot3 = "v2a4_wuerlixi_node_icon4"
		end

		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageiconbg, slot3)
	end
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

return slot0
