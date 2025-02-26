module("modules.logic.rouge.view.RougeResultView", package.seeall)

slot0 = class("RougeResultView", BaseView)
slot0.BeginType = 1
slot0.MinMiddleType = 2
slot0.MaxMiddleType = 5
slot0.EndType = 6
slot0.StartResultIndex = 1
slot0.OnePageShowResultCount = 2

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "Content/#txt_dec")
	slot0._goevent = gohelper.findChild(slot0.viewGO, "Content/#go_event")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "Content/#go_event/#go_item1")
	slot0._txtevent = gohelper.findChildText(slot0.viewGO, "Content/#go_event/#go_item1/scroll_desc/viewport/#txt_event")
	slot0._goitem2 = gohelper.findChild(slot0.viewGO, "Content/#go_event/#go_item2")
	slot0._goitem3 = gohelper.findChild(slot0.viewGO, "Content/#go_event/#go_item3")
	slot0._goitem4 = gohelper.findChild(slot0.viewGO, "Content/#go_event/#go_item4")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "Content/#go_fail")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "Content/#go_fail/#simage_mask")
	slot0._simagemask2 = gohelper.findChildSingleImage(slot0.viewGO, "Content/#go_fail/#simage_mask2")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "Content/#go_success")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "Content/#go_arrow")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Content/Title/#txt_Title")
	slot0._simagerightmask = gohelper.findChildSingleImage(slot0.viewGO, "Content/img_dec/#simage_rightmask")
	slot0._simageleftmask = gohelper.findChildSingleImage(slot0.viewGO, "Content/img_dec/#simage_leftmask")
	slot0._simagerightmask2 = gohelper.findChildSingleImage(slot0.viewGO, "Content/img_dec/#simage_rightmask2")
	slot0._simageleftmask2 = gohelper.findChildSingleImage(slot0.viewGO, "Content/img_dec/#simage_leftmask2")
	slot0._simagepoint = gohelper.findChildSingleImage(slot0.viewGO, "Content/img_dec/#simage_point")
	slot0._simagepoint2 = gohelper.findChildSingleImage(slot0.viewGO, "Content/img_dec/#simage_point2")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "Content/#btn_skip")
	slot0._imageskip = gohelper.findChildImage(slot0.viewGO, "Content/#btn_skip/#image_skip")
	slot0._btnnext = gohelper.findChildButton(slot0.viewGO, "Content/#btn_next")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnskip:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
end

function slot0._btnskipOnClick(slot0)
	RougeController.instance:openRougeSettlementView()
end

function slot0._btnnextOnClick(slot0)
	TaskDispatcher.cancelTask(slot0.playStartSettlementTxtAudio, slot0)

	if slot0._isSwitch2EndingView then
		RougeController.instance:openRougeSettlementView()
	elseif slot0:isHasNeedShowResultItem(slot0._curEventEndIndex + 1) then
		slot0:try2ShowResult(slot1)
		AudioMgr.instance:trigger(AudioEnum.UI.NextShowSettlementTxt)
	else
		slot0:switch2Ending()
		AudioMgr.instance:trigger(AudioEnum.UI.ShowEndingTxt)
	end
end

function slot0._editableInitView(slot0)
	slot0._isSwitch2EndingView = false
	slot0._curEventEndIndex = 0
	slot0._configMap = slot0:buildConfigMap()
	slot0._descList = slot0:getTriggerConfigs()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.SettlementCloseWindow)
end

slot1 = 2

function slot0.onOpenFinish(slot0)
	slot0:onBeforeShowResultContent()
	TaskDispatcher.cancelTask(slot0.playStartSettlementTxtAudio, slot0)
	TaskDispatcher.runDelay(slot0.playStartSettlementTxtAudio, slot0, uv0)
end

function slot0.playStartSettlementTxtAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.StartShowSettlementTxt)
end

function slot0.onUpdateParam(slot0)
	slot0:onBeforeShowResultContent()

	slot0._isSwitch2EndingView = false
	slot0._curEventEndIndex = 0
end

function slot0.onBeforeShowResultContent(slot0)
	if slot0:filterTypeGroupCfgs(uv0.BeginType) then
		slot0._txtdec.text = slot1 and slot1[1]

		gohelper.setActive(slot0._txtdec.gameObject, true)
	end

	gohelper.setActive(slot0._gofail, false)
	gohelper.setActive(slot0._gosuccess, false)
	gohelper.setActive(slot0._goarrow, false)
	gohelper.setActive(slot0._goevent, false)
end

function slot0.showRougeResultList(slot0)
	slot0:try2ShowResult(uv0.StartResultIndex)
	gohelper.setActive(slot0._goarrow, true)
	gohelper.setActive(slot0._txtdec.gameObject, false)
end

function slot0.buildConfigMap(slot0)
	slot4 = {}

	if lua_rouge_result.configDict[RougeModel.instance:getRougeResult() and slot1.season] then
		for slot8, slot9 in pairs(slot3) do
			slot4[slot10] = slot4[slot9.type] or {}

			table.insert(slot4[slot10], slot9)
		end
	end

	for slot8, slot9 in pairs(slot4) do
		table.sort(slot9, slot0.configSortFunction)
	end

	return slot4
end

function slot0.configSortFunction(slot0, slot1)
	if slot0.priority ~= slot1.priority then
		return slot2 < slot3
	end

	return slot0.id < slot1.id
end

slot2 = 3

function slot0.getTriggerConfigs(slot0)
	slot1 = {}

	for slot5 = uv0.MinMiddleType, uv0.MaxMiddleType do
		if slot0:filterTypeGroupCfgs(slot5) and #slot6 > 0 then
			table.insert(slot1, {
				eventType = slot5,
				contents = slot6
			})
		end
	end

	return slot1
end

function slot0.filterTypeGroupCfgs(slot0, slot1)
	if not (slot0._configMap and slot0._configMap[slot1]) then
		return
	end

	slot3 = {}

	for slot8, slot9 in ipairs(slot2) do
		if not string.nilorempty(slot0:tryFilterTrigger(slot9)) then
			table.insert(slot3, slot10)

			if uv0 <= 0 + 1 then
				break
			end
		end
	end

	return slot3
end

function slot0.tryFilterTrigger(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = {
		0
	}

	if not string.nilorempty(slot1.triggerParam) then
		slot2 = string.splitToNumber(slot1.triggerParam, "#")
	end

	if {
		RougeSettlementTriggerHelper.isResultTrigger(slot1.trigger, unpack(slot2))
	} and slot3[1] ~= nil or slot0:checkIsTriggerDefaultVisible(slot1) then
		return GameUtil.getSubPlaceholderLuaLang(slot1.desc, slot3)
	end
end

function slot0.checkIsTriggerDefaultVisible(slot0, slot1)
	return slot1 and slot1.priority == 0
end

function slot0.try2ShowResult(slot0, slot1)
	if not slot0._descList then
		return
	end

	if slot1 > #slot0._descList then
		return
	end

	if slot2 < slot1 + uv0.OnePageShowResultCount - 1 then
		slot3 = slot2 or slot3
	end

	slot0:setAllResultItemVisible(false)

	for slot7 = slot1, slot3 do
		slot0:refreshResultContent(slot0:getOrCreateResultItem(slot7), slot0._descList[slot7])
	end

	slot0._curEventEndIndex = slot3

	gohelper.setActive(slot0._goevent, true)
	gohelper.setActive(slot0._txtdec.gameObject, false)
end

function slot0.getOrCreateResultItem(slot0, slot1)
	return slot0["_goitem" .. slot1]
end

function slot0.setAllResultItemVisible(slot0, slot1)
	for slot6 = 1, slot0._goevent.transform.childCount do
		gohelper.setActive(slot0._goevent.transform:GetChild(slot6 - 1), slot1)
	end
end

slot3 = {
	nil,
	"rouge_result_icon_box",
	"rouge_result_icon_beasts",
	"rouge_result_icon_party",
	"rouge_result_icon_location"
}

function slot0.refreshResultContent(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	gohelper.findChildText(slot1, "scroll_desc/viewport/#txt_event").text = table.concat(slot2.contents, "\n")

	if uv0[slot2.eventType] then
		UISpriteSetMgr.instance:setRouge2Sprite(gohelper.findChildImage(slot1, "#imgae_icon"), slot6)
	end

	gohelper.setActive(slot1, true)
end

function slot0.isHasNeedShowResultItem(slot0, slot1)
	return slot1 <= (slot0._descList and #slot0._descList or 0)
end

function slot0.switch2Ending(slot0)
	slot2 = RougeModel.instance:getRougeResult() and slot1:isSucceed()

	gohelper.setActive(slot0._gofail, not slot2)
	gohelper.setActive(slot0._gosuccess, slot2)
	gohelper.setActive(slot0._goarrow, false)
	slot0:setAllResultItemVisible(false)

	slot0._isSwitch2EndingView = true

	if slot2 then
		gohelper.findChildText(slot0._gosuccess, "txt_success").text = slot0:filterTypeGroupCfgs(uv0.EndType) and slot3[1] or ""
	else
		gohelper.findChildText(slot0._gofail, "txt_fail").text = slot4
	end
end

function slot0.getRougeResultCfg(slot0, slot1, slot2)
	if slot0._configMap[slot1] then
		for slot7, slot8 in ipairs(slot3) do
			if slot8.season == slot2 then
				return slot8
			end
		end
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.playStartSettlementTxtAudio, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
