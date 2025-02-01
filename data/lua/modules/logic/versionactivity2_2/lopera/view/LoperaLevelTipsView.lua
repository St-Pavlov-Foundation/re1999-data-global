module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelTipsView", package.seeall)

slot0 = class("LoperaLevelTipsView", BaseView)
slot1 = LoperaEnum.MapCfgIdx
slot2 = VersionActivity2_2Enum.ActivityId.Lopera
slot3 = 3

function slot0.onInitView(slot0)
	slot0._text = gohelper.findChildText(slot0.viewGO, "Bg/#text")
	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_min_day_night)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeFinish, slot0._onGetToDestination, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeMove, slot0._onMoveInEpisode, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.ExitGame, slot0.onExitGame, slot0)

	slot1 = slot0.viewParam
	slot2 = slot1.isBeginning
	slot0._isFinishTips = slot1.isFinished
	slot4 = slot1.mapId

	if slot1.isEndLess then
		slot0._text.text = Activity168Config.instance:getConstCfg(uv0, Activity168Model.instance:getCurEpisodeId()).value2

		slot0:_delayClose()
	elseif slot2 or slot0._isFinishTips then
		slot0._text.text = string.split(Activity168Config.instance:getConstValueCfg(uv0, slot4).value2, "|")[slot2 and 1 or 2]

		slot0:_delayClose()
	else
		slot8 = Activity168Config.instance:getMapCell(slot1.cellIdx - 1)[uv1.coord]
		slot9 = Activity168Config.instance:getMapEndCell()[uv1.coord]
		slot10 = math.abs(slot8[1] - slot9[1]) + math.abs(slot8[2] - slot9[2])

		for slot17, slot18 in ipairs(string.split(Activity168Config.instance:getConstCfg(uv0, 1).mlValue, "|")) do
			slot19 = string.split(slot18, "#")
		end

		slot14 = ""

		for slot18, slot19 in pairs({
			[tonumber(slot19[1])] = slot19[2]
		}) do
			if slot18 <= slot10 then
				slot14 = slot19
			else
				break
			end
		end

		slot15 = slot8[1] < slot9[1] and luaLang("text_dir_east") or slot9[1] < slot8[1] and luaLang("text_dir_west") or ""
		slot16 = slot8[2] < slot9[2] and luaLang("text_dir_north") or slot9[2] < slot8[2] and luaLang("text_dir_south") or ""
		slot19 = nil
		slot0._text.text = GameUtil.getSubPlaceholderLuaLang(Activity168Config.instance:getConstValueCfg(uv0, slot1.mapId).mlValue, (not LangSettings.instance:isEn() or (not string.nilorempty(slot16) or {
			slot14,
			slot15
		}) and {
			slot14,
			slot15 .. "-" .. slot16
		}) and {
			slot14,
			slot15 .. slot16
		})
	end
end

function slot0._delayClose(slot0)
	TaskDispatcher.runDelay(slot0._doCloseAction, slot0, uv0)
end

function slot0._doCloseAction(slot0)
	slot0._viewAnimator:Play("out", 0, 0)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 0.25)
end

function slot0._onGetToDestination(slot0, slot1)
	if LoperaEnum.ResultEnum.Quit == slot1.settleReason or LoperaEnum.ResultEnum.PowerUseup == slot2 then
		slot0:_doCloseAction()
	end
end

function slot0._onMoveInEpisode(slot0)
	if not slot0._isFinishTips then
		slot0:_doCloseAction()
	end
end

function slot0.onExitGame(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	TaskDispatcher.cancelTask(slot0._doCloseAction, slot0)
end

return slot0
