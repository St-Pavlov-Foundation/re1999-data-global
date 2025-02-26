module("modules.logic.versionactivity2_3.act174.view.Act174MatchView", package.seeall)

slot0 = class("Act174MatchView", BaseView)
slot1 = 6

function slot0.onInitView(slot0)
	slot0._gosearching = gohelper.findChild(slot0.viewGO, "#go_searching")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searching/#btn_cancel")
	slot0._txtsearching = gohelper.findChildText(slot0.viewGO, "#go_searching/#txt_searching")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._btncancelgrey = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_success/#btn_cancel_grey")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btncancelgrey:AddClickListener(slot0._btncancelgreyOnClick, slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncancel:RemoveClickListener()
	slot0._btncancelgrey:RemoveClickListener()
end

function slot0._btncancelOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act174.stop_ui_shenghuo_dqq_match_success)
	slot0:closeThis()
end

function slot0._btncancelgreyOnClick(slot0)
end

function slot0._onEscBtnClick(slot0)
	if slot0._btncancelgrey.gameObject.activeInHierarchy then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act174.stop_ui_shenghuo_dqq_match_success)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.txtList = {}

	for slot4 = 1, uv0 do
		slot0.txtList[#slot0.txtList + 1] = gohelper.findChildText(slot0.viewGO, "#go_searching/searching/#txt_searching" .. slot4)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:setRandomTxt()
	TaskDispatcher.runDelay(slot0.waitEnd, slot0, tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.MatchWaitTime].value))
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_match_success)
end

function slot0.setRandomTxt(slot0)
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))

	for slot7 = 1, uv0 do
		slot8 = math.random(slot7, #string.split(lua_activity174_const.configDict[Activity174Enum.ConstKey.MatchTxt].value2, "#"))
		slot2[slot7] = slot2[slot8]
		slot2[slot8] = slot2[slot7]
	end

	for slot7, slot8 in ipairs(slot0.txtList) do
		slot8.text = slot2[slot7]
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.waitEnd, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.waitEnd(slot0)
	Activity174Rpc.instance:sendStartAct174FightMatchRequest(Activity174Model.instance:getCurActId(), slot0.matchCallback, slot0)
end

function slot0.matchCallback(slot0)
	gohelper.setActive(slot0._gosearching, false)
	gohelper.setActive(slot0._gosuccess, true)
	Activity174Controller.instance:openFightReadyView()
	ViewMgr.instance:closeView(ViewName.Act174GameView, true)
	slot0:closeThis()
end

return slot0
