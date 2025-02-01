module("modules.logic.weekwalk.view.WeekWalkResetBattleItem", package.seeall)

slot0 = class("WeekWalkResetBattleItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._gounfinish = gohelper.findChild(slot0.viewGO, "#go_unfinish")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._godisable = gohelper.findChild(slot0.viewGO, "#go_disable")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "#txt_index")
	slot0._gostars2 = gohelper.findChild(slot0.viewGO, "#go_stars2")
	slot0._go2star1 = gohelper.findChild(slot0.viewGO, "#go_stars2/#go_2star1")
	slot0._go2star2 = gohelper.findChild(slot0.viewGO, "#go_stars2/#go_2star2")
	slot0._gostars3 = gohelper.findChild(slot0.viewGO, "#go_stars3")
	slot0._go3star1 = gohelper.findChild(slot0.viewGO, "#go_stars3/#go_3star1")
	slot0._go3star2 = gohelper.findChild(slot0.viewGO, "#go_stars3/#go_3star2")
	slot0._go3star3 = gohelper.findChild(slot0.viewGO, "#go_stars3/#go_3star3")
	slot0._goconnectline = gohelper.findChild(slot0.viewGO, "#go_connectline")
	slot0._gofinishline = gohelper.findChild(slot0.viewGO, "#go_connectline/#go_finishline")
	slot0._gounfinishline = gohelper.findChild(slot0.viewGO, "#go_connectline/#go_unfinishline")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._battleInfo.star <= 0 then
		return
	end

	slot0._resetView:selectBattleItem(slot0)
end

function slot0.setSelect(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot1)
end

function slot0.ctor(slot0, slot1)
	slot0._resetView = slot1[1]
	slot0._battleInfo = slot1[2]
	slot0._index = slot1[3]
	slot0._battleInfos = slot1[4]
	slot0._maxNum = #slot0._battleInfos
	slot0._mapInfo = WeekWalkModel.instance:getCurMapInfo()
end

function slot0.getBattleInfo(slot0)
	return slot0._battleInfo
end

function slot0.getPrevBattleInfo(slot0)
	return slot0._battleInfos[slot0._index - 1]
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnclick.gameObject, AudioEnum.UI.Play_UI_Copies)

	slot0._stars2CanvasGroup = gohelper.onceAddComponent(slot0._gostars2, typeof(UnityEngine.CanvasGroup))
	slot0._stars3CanvasGroup = gohelper.onceAddComponent(slot0._gostars3, typeof(UnityEngine.CanvasGroup))
	slot0._txtindex.text = string.format("0%s", slot0._index)

	slot0:setSelect(false)
	slot0:_setNormalStatus()
end

function slot0._setStarStatus(slot0, slot1)
	gohelper.setActive(slot0._gostars2, slot0._mapInfo:getStarNumConfig() == 2)
	gohelper.setActive(slot0._gostars3, slot2 == 3)

	for slot6 = 1, slot2 do
		gohelper.setActive(gohelper.findChild(slot0[string.format("_go%sstar%s", slot2, slot6)], "full"), slot6 <= slot1)
	end
end

function slot0._setNormalStatus(slot0)
	slot2 = slot0._battleInfo.star > 0

	slot0:_updateFinishLine(slot2)
	slot0:_initBattleStatus(slot0:_getPrevFinish(), slot2)
	slot0:_setStarStatus(slot0._battleInfo.star)
end

function slot0._setFakedStatus(slot0, slot1)
	slot0:_updateFinishLine(false)

	if not (slot0._battleInfo.star > 0) and slot0:_getPrevFinish() then
		slot0:_initBattleStatus(false, slot2)

		return
	end

	if not slot1 then
		slot2 = false
	end

	slot0:_initBattleStatus(slot3, slot2)
end

function slot0.setFakedReset(slot0, slot1, slot2)
	if slot1 then
		slot0:_setFakedStatus(slot2)
	else
		slot0:_setNormalStatus()
	end
end

function slot0._updateFinishLine(slot0, slot1)
	if slot0._index < slot0._maxNum then
		gohelper.setActive(slot0._gofinishline, slot1)
		gohelper.setActive(slot0._gounfinishline, not slot1)
	else
		gohelper.setActive(slot0._gofinishline, false)
		gohelper.setActive(slot0._gounfinishline, false)
	end
end

function slot0._initBattleStatus(slot0, slot1, slot2)
	gohelper.setActive(slot0._godisable, false)
	gohelper.setActive(slot0._gofinish, false)
	gohelper.setActive(slot0._gounfinish, false)

	slot0._stars2CanvasGroup.alpha = slot2 and 1 or 0.2
	slot0._stars3CanvasGroup.alpha = slot2 and 1 or 0.2

	ZProj.UGUIHelper.SetColorAlpha(slot0._txtindex, slot2 and 1 or 0.3)

	slot3 = slot0._battleInfo.star <= 0 or not slot1

	gohelper.setActive(slot0._godisable, slot3)

	if slot3 then
		return
	end

	gohelper.setActive(slot0._gofinish, slot2)
	gohelper.setActive(slot0._gounfinish, not slot2)
end

function slot0._getPrevFinish(slot0)
	return not slot0._battleInfos[slot0._index - 1] or slot1.star > 0
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
