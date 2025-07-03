module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroDungeonMapView", package.seeall)

local var_0_0 = class("DiceHeroDungeonMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_dicebtn")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_dicebtn/#btn_enter", AudioEnum2_6.DiceHero.play_ui_wenming_alaifugameplay)
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "#go_dicebtn/#btn_enter/#go_reddot")
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "#go_dicebtn/#btn_enter")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0.onClickEnter, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(DiceHeroController.instance, DiceHeroEvent.InfoUpdate, arg_2_0.onActStateChange, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_2_0.setEpisodeListVisible, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0.onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0.onCloseViewFinish, arg_3_0)
	arg_3_0:removeEventCb(DiceHeroController.instance, DiceHeroEvent.InfoUpdate, arg_3_0.onActStateChange, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_3_0.setEpisodeListVisible, arg_3_0)
end

function var_0_0.refreshView(arg_4_0)
	arg_4_0.chapterId = arg_4_0.viewParam.chapterId

	arg_4_0:onActStateChange()
	RedDotController.instance:addRedDot(arg_4_0._gored, RedDotEnum.DotNode.V2a6DiceHero)

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
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DiceHero) and arg_10_0.chapterId == DungeonEnum.ChapterId.Main1_9 then
		return true
	end
end

function var_0_0.onActStateChange(arg_11_0)
	if arg_11_0:isShowRoot() then
		gohelper.setActive(arg_11_0._goroot, true)
	else
		gohelper.setActive(arg_11_0._goroot, false)
	end
end

function var_0_0.onClickEnter(arg_12_0)
	ViewMgr.instance:openView(ViewName.DiceHeroMainView)
end

return var_0_0
