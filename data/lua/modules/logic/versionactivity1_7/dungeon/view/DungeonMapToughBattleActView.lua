module("modules.logic.versionactivity1_7.dungeon.view.DungeonMapToughBattleActView", package.seeall)

local var_0_0 = class("DungeonMapToughBattleActView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_toughbattle")
	arg_1_0._gotoughbattle = gohelper.findChild(arg_1_0.viewGO, "#go_toughbattle/#go_toughbattle")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_toughbattle/#go_toughbattle/#btn_entry")
	arg_1_0._gochallenge = gohelper.findChild(arg_1_0.viewGO, "#go_toughbattle/#go_toughbattle/#btn_entry/go_challenge")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "#go_toughbattle/#go_toughbattle/#go_reddot")
	arg_1_0._anim = arg_1_0._gotoughbattle:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0.onClickToughBattle, arg_2_0)
	arg_2_0:addEventCb(ToughBattleController.instance, ToughBattleEvent.ToughBattleActChange, arg_2_0.onActStateChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_2_0.setEpisodeListVisible, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.ToughBattleActChange, arg_3_0.onActStateChange, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0.onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0.onCloseViewFinish, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_3_0.setEpisodeListVisible, arg_3_0)
end

function var_0_0.refreshView(arg_4_0)
	arg_4_0.chapterId = arg_4_0.viewParam.chapterId

	arg_4_0:onActStateChange()
	RedDotController.instance:addRedDot(arg_4_0._gored, RedDotEnum.DotNode.V1a9ToughBattle)

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		arg_4_0._anim:Play("close", 0, 1)
	else
		arg_4_0._anim:Play("open", 0, 0)
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshView()
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onOpenView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.DungeonMapLevelView then
		arg_7_0._anim:Play("close", 0, 0)
	end
end

function var_0_0.onCloseViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.DungeonMapLevelView then
		arg_8_0._anim:Play("open", 0, 0)
	end
end

function var_0_0.setEpisodeListVisible(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_0:isShowRoot() then
		arg_9_0._anim:Play("open", 0, 0)
	else
		arg_9_0._anim:Play("close", 0, 0)
	end
end

function var_0_0.isShowRoot(arg_10_0)
	if ToughBattleModel.instance:getActIsOnline() and arg_10_0.chapterId == DungeonEnum.ChapterId.Main1_7 then
		return true
	end
end

function var_0_0.onActStateChange(arg_11_0)
	if arg_11_0:isShowRoot() then
		gohelper.setActive(arg_11_0._gotoughbattle, true)
		gohelper.setActive(arg_11_0._goroot, true)

		local var_11_0 = ToughBattleModel.instance:getActInfo()

		gohelper.setActive(arg_11_0._gochallenge, var_11_0.openChallenge)
	else
		gohelper.setActive(arg_11_0._gotoughbattle, false)
		gohelper.setActive(arg_11_0._goroot, false)
	end
end

function var_0_0.onClickToughBattle(arg_12_0)
	ToughBattleModel.instance:setIsJumpActElement(true)

	if not arg_12_0:isInMain_7_28() then
		JumpController.instance:jumpByParam("4#10728#1")
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, ToughBattleEnum.ActElementId)
end

function var_0_0.isInMain_7_28(arg_13_0)
	local var_13_0 = arg_13_0.viewContainer:getMapScene()

	if not var_13_0 then
		return false
	end

	local var_13_1 = var_13_0._mapCfg

	if not var_13_1 then
		return false
	end

	return var_13_1.id == ToughBattleEnum.MapId_7_28
end

return var_0_0
