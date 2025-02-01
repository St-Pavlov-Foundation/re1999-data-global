module("modules.logic.rouge.dlc.101.view.RougeLimiterResultView", package.seeall)

slot0 = class("RougeLimiterResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._imagebadge = gohelper.findChildImage(slot0.viewGO, "Single/Top/#image_badge")
	slot0._goadd1 = gohelper.findChild(slot0.viewGO, "Single/Top/#go_add1")
	slot0._txtadd1 = gohelper.findChildText(slot0.viewGO, "Single/Top/#go_add1/#txt_add1")
	slot0._gocurrent1 = gohelper.findChild(slot0.viewGO, "Single/Top/#go_current1")
	slot0._txtcurrent1 = gohelper.findChildText(slot0.viewGO, "Single/Top/#go_current1/#txt_current1")
	slot0._goadd2 = gohelper.findChild(slot0.viewGO, "Two/Top/#go_add2")
	slot0._txtadd2 = gohelper.findChildText(slot0.viewGO, "Two/Top/#go_add2/#txt_add2")
	slot0._gocurrent2 = gohelper.findChild(slot0.viewGO, "Two/Top/#go_current2")
	slot0._txtcurrent2 = gohelper.findChildText(slot0.viewGO, "Two/Top/#go_current2/#txt_current2")
	slot0._gobuffitem = gohelper.findChild(slot0.viewGO, "Two/Bottom/#go_buffitem")
	slot0._imagebufficon = gohelper.findChildImage(slot0.viewGO, "Two/Bottom/#go_buffitem/#image_bufficon")
	slot0._txtbuffname = gohelper.findChildText(slot0.viewGO, "Two/Bottom/#go_buffitem/#txt_buffname")
	slot0._txtbuffdec = gohelper.findChildText(slot0.viewGO, "Two/Bottom/#go_buffitem/#txt_buffdec")
	slot0._btnclosebtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closebtn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosebtn:AddClickListener(slot0._btnclosebtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosebtn:RemoveClickListener()
end

function slot0._btnclosebtnOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._gosingle = gohelper.findChild(slot0.viewGO, "Single")
	slot0._gotwo = gohelper.findChild(slot0.viewGO, "Two")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenLimiterResultView)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot2 = RougeModel.instance:getRougeResult() and slot1:getLimiterResultMo()
	slot3 = slot2 and slot2:getLimiterUseBuffIds()
	slot4 = slot3 and #slot3 > 0

	gohelper.setActive(slot0._gosingle, not slot4)
	gohelper.setActive(slot0._gotwo, slot4)
	slot0:refreshEmblem(slot4, slot2 and slot2:getPreEmbleCount(), slot2 and slot2:getLimiterAddEmblem())
	slot0:refreshCDBuffs(slot3)
end

function slot0.refreshEmblem(slot0, slot1, slot2, slot3)
	slot5 = lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.MaxEmblemCount] and tonumber(slot4.value) or 0
	slot7 = slot3

	if GameUtil.clamp(slot5 - slot2, 0, slot5) < slot3 then
		slot7 = slot6
	end

	slot8 = slot2 + slot7
	slot9 = string.format("+ %s", slot7 or 0)

	if slot5 <= slot8 then
		slot10 = string.format("%s (MAX)", formatLuaLang("rouge_dlc_101_emblemCount", slot8))
	end

	if slot1 then
		slot0._txtadd2.text = slot9
		slot0._txtcurrent2.text = slot10
	else
		slot0._txtadd1.text = slot9
		slot0._txtcurrent1.text = slot10
	end
end

function slot0.refreshCDBuffs(slot0, slot1)
	slot2 = {
		[slot8] = true
	}

	for slot6, slot7 in ipairs(slot1 or {}) do
		slot8 = slot0:_getOrCreateBuffItem(slot6)

		gohelper.setActive(slot8.viewGO, true)

		slot8.txtTitle.text = RougeDLCConfig101.instance:getLimiterBuffCo(slot7) and slot9.title
		slot8.txtDec.text = slot9 and slot9.desc

		UISpriteSetMgr.instance:setRouge4Sprite(slot8.imageIcon, slot9.icon)
	end

	if slot0._buffItemTab then
		for slot6, slot7 in pairs(slot0._buffItemTab) do
			if not slot2[slot7] then
				gohelper.setActive(slot7.viewGO, false)
			end
		end
	end
end

function slot0._getOrCreateBuffItem(slot0, slot1)
	slot0._buffItemTab = slot0.buffItemTab or slot0:getUserDataTb_()

	if not slot0._buffItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._gobuffitem, "buffitem_" .. slot1)
		slot2.txtTitle = gohelper.findChildText(slot2.viewGO, "#txt_buffname")
		slot2.txtDec = gohelper.findChildText(slot2.viewGO, "#txt_buffdec")
		slot2.imageIcon = gohelper.findChildImage(slot2.viewGO, "#image_bufficon")
		slot0._buffItemTab[slot1] = slot2
	end

	return slot2
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
