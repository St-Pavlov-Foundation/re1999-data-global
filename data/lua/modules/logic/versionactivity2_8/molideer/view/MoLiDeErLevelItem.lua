module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErLevelItem", package.seeall)

local var_0_0 = class("MoLiDeErLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.viewGO, "#image_point_normal")
	arg_1_0._imagepointFinish = gohelper.findChildImage(arg_1_0.viewGO, "#image_point_finish")
	arg_1_0._gostagefinish = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagefinish")
	arg_1_0._gostagenormal = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagenormal")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stagename")
	arg_1_0._txtstageNum = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stageNum")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "unlock/info/#go_star")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#btn_click")
	arg_1_0._goCurrent = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_Current")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	local var_4_0 = arg_4_0.actId
	local var_4_1 = ActivityModel.instance:getActMO(var_4_0)

	if var_4_1 == nil then
		logError("not such activity id: " .. var_4_0)

		return
	end

	if not var_4_1:isOpen() or var_4_1:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	local var_4_2 = arg_4_0.episodeConfig.preEpisodeId

	if var_4_2 ~= 0 and not MoLiDeErModel.instance:isEpisodeFinish(var_4_0, var_4_2) then
		GameFacade.showToast(ToastEnum.Act194EpisodeLock)

		return
	end

	local var_4_3 = arg_4_0.episodeConfig.episodeId

	MoLiDeErController.instance:dispatchEvent(MoLiDeErEvent.OnClickEpisodeItem, arg_4_0.index, var_4_3)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._starItemDic = {}
	arg_5_0._starItemParentList = {}
	arg_5_0._starAnimGoList = {}

	local var_5_0 = arg_5_0._gostar.transform
	local var_5_1 = var_5_0.childCount

	for iter_5_0 = 1, var_5_1 do
		local var_5_2 = var_5_0:GetChild(iter_5_0 - 1).transform
		local var_5_3 = gohelper.findChild(var_5_2.gameObject, "has/#Star_ani")

		table.insert(arg_5_0._starItemParentList, var_5_2)

		local var_5_4 = var_5_2.childCount
		local var_5_5 = {}

		for iter_5_1 = 1, var_5_4 do
			local var_5_6 = var_5_2:GetChild(iter_5_1 - 1).gameObject

			table.insert(var_5_5, var_5_6)
		end

		table.insert(arg_5_0._starItemDic, var_5_5)
		table.insert(arg_5_0._starAnimGoList, var_5_3)
	end

	arg_5_0._animator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.setData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index = arg_6_1
	arg_6_0.actId = MoLiDeErModel.instance:getCurActId()
	arg_6_0.episodeId = arg_6_2.episodeId
	arg_6_0.preEpisodeId = arg_6_2.preEpisodeId
	arg_6_0.episodeConfig = arg_6_2
end

function var_0_0.refreshUI(arg_7_0, arg_7_1)
	local var_7_0 = MoLiDeErModel.instance:getEpisodeInfoMo(arg_7_0.actId, arg_7_0.episodeId)
	local var_7_1 = arg_7_0.episodeConfig
	local var_7_2 = var_7_0:isComplete()
	local var_7_3 = arg_7_0.index
	local var_7_4 = var_7_2 and MoLiDeErEnum.LevelItemTitleColor.Complete or MoLiDeErEnum.LevelItemTitleColor.NoComplete

	arg_7_0._txtstagename.text = string.format("<color=%s>%s</color>", var_7_4, var_7_1.name)

	local var_7_5 = var_7_2 and MoLiDeErEnum.LevelItemStateNameColor.Complete or MoLiDeErEnum.LevelItemStateNameColor.NoComplete
	local var_7_6 = var_7_3 >= 10 and tostring(var_7_3) or "0" .. tostring(var_7_3)

	arg_7_0._txtstageNum.text = string.format("<color=%s>STAGE %s</color>", var_7_5, var_7_6)

	gohelper.setActive(arg_7_0._gostagefinish, var_7_2)
	gohelper.setActive(arg_7_0._goCurrent, false)

	local var_7_7 = var_7_2 and MoLiDeErEnum.LevelState.Complete or MoLiDeErEnum.LevelState.Unlock
	local var_7_8 = tostring(var_7_7)

	UISpriteSetMgr.instance:setMoLiDeErSprite(arg_7_0._imagepoint, "v2a8_molideer_game_stage_point_" .. var_7_8)
	UISpriteSetMgr.instance:setMoLiDeErSprite(arg_7_0._imagepointFinish, "v2a8_molideer_game_stage_point_" .. var_7_8)
	arg_7_0:setStarState(arg_7_1)
	arg_7_0:setAnimState(var_7_7, arg_7_1)
end

function var_0_0.setActive(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0.viewGO, arg_8_1)
end

function var_0_0.setAnimState(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1 == MoLiDeErEnum.LevelState.Complete and MoLiDeErEnum.AnimName.LevelItemFinish or MoLiDeErEnum.AnimName.LevelItemUnlock
	local var_9_1 = arg_9_2 and 0 or 1

	arg_9_0._animator:Play(var_9_0, 0, var_9_1)
end

function var_0_0.setStarState(arg_10_0, arg_10_1)
	local var_10_0 = MoLiDeErModel.instance:getEpisodeInfoMo(arg_10_0.actId, arg_10_0.episodeId)
	local var_10_1 = arg_10_0.episodeConfig
	local var_10_2 = var_10_0.passStar
	local var_10_3 = (var_10_1.gameId == nil or var_10_1.gameId == 0) and 1 or 2
	local var_10_4 = arg_10_0._starItemDic
	local var_10_5 = arg_10_0._starAnimGoList
	local var_10_6 = #var_10_4

	for iter_10_0 = 1, var_10_6 do
		local var_10_7 = iter_10_0 <= var_10_2
		local var_10_8 = arg_10_0._previousStar == nil or iter_10_0 > arg_10_0._previousStar and var_10_2 > arg_10_0._previousStar
		local var_10_9 = var_10_4[iter_10_0]
		local var_10_10 = var_10_5[iter_10_0]

		gohelper.setActive(var_10_9[1], not var_10_7)
		gohelper.setActive(var_10_9[2], var_10_7)
		gohelper.setActive(var_10_10, var_10_7 and var_10_8 and arg_10_1)
	end

	if var_10_3 < var_10_6 then
		for iter_10_1 = var_10_3 + 1, var_10_6 do
			local var_10_11 = arg_10_0._starItemParentList[iter_10_1]

			gohelper.setActive(var_10_11, false)
		end
	end

	arg_10_0._previousStar = var_10_2
end

function var_0_0.setFocus(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goCurrent, arg_11_1)
end

function var_0_0.onDestroy(arg_12_0)
	return
end

return var_0_0
