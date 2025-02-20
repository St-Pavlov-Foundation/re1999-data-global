module("modules.logic.versionactivity1_4.act129.view.Activity129EntranceView", package.seeall)

slot0 = class("Activity129EntranceView", BaseView)

function slot0.onInitView(slot0)
	slot0.goEntrance = gohelper.findChild(slot0.viewGO, "#go_Entrance")
	slot0.txtLimitTime = gohelper.findChildTextMesh(slot0.viewGO, "#go_Entrance/Title/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0.itemDict = {}
	slot0.anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, slot0.onEnterPool, slot0)
	slot0:addEventCb(Activity129Controller.instance, Activity129Event.OnGetInfoSuccess, slot0.OnGetInfoSuccess, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, slot0.onEnterPool, slot0)
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnGetInfoSuccess, slot0.OnGetInfoSuccess, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onEnterPool(slot0)
	slot0:refreshView()
end

function slot0.OnGetInfoSuccess(slot0)
	slot0:refreshView(true)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.isOpen = true

	slot0:refreshView()
end

function slot0.refreshView(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.refreshLeftTime, slot0)

	if Activity129Model.instance:getSelectPoolId() then
		gohelper.setActive(slot0.goEntrance, false)

		slot0.isOpen = false

		return
	end

	gohelper.setActive(slot0.goEntrance, true)

	if not slot0.isOpen then
		slot0.anim:Play("switch", 0, 0)
	end

	slot0.isOpen = true

	if not slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_open)
	end

	if Activity129Config.instance:getPoolDict(slot0.actId) then
		for slot7, slot8 in pairs(slot3) do
			slot0:refreshPoolItem(slot0.itemDict[slot8.poolId] or slot0:createPoolItem(slot8.poolId), slot8)
		end
	end

	slot0:refreshLeftTime()
	TaskDispatcher.runRepeat(slot0.refreshLeftTime, slot0, 60)
end

function slot0.createPoolItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.poolId = slot1
	slot2.go = gohelper.findChild(slot0.goEntrance, string.format("Item%s", slot1))
	slot2.goItems = gohelper.findChild(slot2.go, "items")
	slot2.txtItemTitle = gohelper.findChildTextMesh(slot2.go, "items/txt_ItemTitle")
	slot2.goGet = gohelper.findChild(slot2.go, "#go_Get")
	slot2.click = gohelper.findChildClickWithAudio(slot2.go, "click", AudioEnum.UI.play_ui_payment_click)

	slot2.click:AddClickListener(slot0._onClickItem, slot0, slot2)

	slot2.simages = slot2.goItems:GetComponentsInChildren(typeof(SLFramework.UGUI.SingleImage), true)
	slot3 = slot2.simages:GetEnumerator()

	while slot3:MoveNext() do
		slot3.Current.curImageUrl = nil

		slot3.Current:LoadImage(slot3.Current.curImageUrl)
	end

	slot2.graphics = {}
	slot5 = slot2.goItems:GetComponentsInChildren(gohelper.Type_Image, true):GetEnumerator()

	while slot5:MoveNext() do
		table.insert(slot2.graphics, {
			comp = slot5.Current,
			color = GameUtil.colorToHex(slot5.Current.color)
		})
	end

	slot7 = slot2.goItems:GetComponentsInChildren(gohelper.Type_TextMesh, true):GetEnumerator()

	while slot7:MoveNext() do
		table.insert(slot2.graphics, {
			comp = slot7.Current,
			color = GameUtil.colorToHex(slot7.Current.color)
		})
	end

	slot0.itemDict[slot1] = slot2

	return slot2
end

function slot0.refreshPoolItem(slot0, slot1, slot2)
	slot1.txtItemTitle.text = slot2.name
	slot7 = Activity129Model.instance:checkPoolIsEmpty(slot0.actId, slot2.poolId)

	gohelper.setActive(slot1.goGet, slot7)

	for slot7, slot8 in ipairs(slot1.graphics) do
		SLFramework.UGUI.GuiHelper.SetColor(slot8.comp, slot3 and "#808080" or slot8.color)
	end
end

function slot0._onClickItem(slot0, slot1)
	Activity129Model.instance:setSelectPoolId(slot1.poolId)
end

function slot0.refreshLeftTime(slot0)
	if ActivityModel.instance:getActMO(slot0.actId) then
		slot0.txtLimitTime.text = formatLuaLang("remain", string.format("%s%s", slot1:getRemainTime()))
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshLeftTime, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.itemDict) do
		slot6 = slot5.simages:GetEnumerator()

		while slot6:MoveNext() do
			slot6.Current:UnLoadImage()
		end

		slot5.click:RemoveClickListener()
	end
end

return slot0
