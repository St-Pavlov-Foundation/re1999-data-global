module("modules.logic.rouge.dlc.101.view.RougeLimiterDebuffOverListItem", package.seeall)

slot0 = class("RougeLimiterDebuffOverListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagedebufficon = gohelper.findChildImage(slot0.viewGO, "#image_debufficon")
	slot0._txtbufflevel = gohelper.findChildText(slot0.viewGO, "#txt_bufflevel")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#txt_dec")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._config = slot1
	slot0._txtbufflevel.text = GameUtil.getRomanNums(slot0._config.level)
	slot0._txtname.text = slot0._config and slot0._config.title
	slot0._txtdec.text = slot0._config and slot0._config.desc

	UISpriteSetMgr.instance:setRouge4Sprite(slot0._imagedebufficon, RougeDLCConfig101.instance:getLimiterGroupCo(slot0._config.group) and slot2.icon)
end

function slot0.onDestroyView(slot0)
end

return slot0
