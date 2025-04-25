module("modules.logic.versionactivity2_5.act186.view.Activity186StageItem", package.seeall)

slot0 = class("Activity186StageItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.goSelect = gohelper.findChild(slot0.viewGO, "goSelect")
	slot0.goLock = gohelper.findChild(slot0.viewGO, "goLock")
	slot0.goTimeBg = gohelper.findChild(slot0.viewGO, "goLock/timeBg")
	slot0.txtTime = gohelper.findChildTextMesh(slot0.viewGO, "goLock/timeBg/txt")
	slot0.goEnd = gohelper.findChild(slot0.viewGO, "goEnd")
	slot0.btnClick = gohelper.findButtonWithAudio(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnClick:AddClickListener(slot0.onClickBtn, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnClick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtn(slot0)
	if not slot0._mo then
		return
	end

	slot2 = slot0._mo.id < slot0._mo.actMo.currentStage
	slot4 = slot1 < slot0._mo.id

	if slot1 == slot0._mo.id then
		return
	end

	if slot4 then
		if lua_actvity186_stage.configDict[slot0._mo.actMo.id] and slot5[slot0._mo.id] then
			GameFacade.showToastString(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), math.ceil((TimeUtil.stringToTimestamp(slot6.startTime) - ServerTime.now()) / TimeUtil.OneDaySecond)))
		end

		return
	end

	GameFacade.showToast(ToastEnum.Act186StageEnd)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshView()
end

function slot0.refreshView(slot0)
	gohelper.setActive(slot0.goSelect, slot1 == slot0._mo.id)
	gohelper.setActive(slot0.goLock, slot1 < slot0._mo.id)
	gohelper.setActive(slot0.goEnd, slot0._mo.id < slot0._mo.actMo.currentStage)

	if slot1 + 1 == slot0._mo.id then
		gohelper.setActive(slot0.goTimeBg, true)
		slot0:_showDeadline()
	else
		gohelper.setActive(slot0.goTimeBg, false)
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end
end

function slot0._showDeadline(slot0)
	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
end

function slot0._onRefreshDeadline(slot0)
	if not slot0._mo then
		return
	end

	if not (lua_actvity186_stage.configDict[slot0._mo.actMo.id] and slot1[slot0._mo.id]) then
		return
	end

	slot0.txtTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), math.ceil((TimeUtil.stringToTimestamp(slot2.startTime) - ServerTime.now()) / TimeUtil.OneDaySecond))
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

return slot0
