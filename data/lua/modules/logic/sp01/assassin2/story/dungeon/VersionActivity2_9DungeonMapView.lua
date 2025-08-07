module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapView", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapView", VersionActivityFixedDungeonMapView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._topRightAnimator = gohelper.onceAddComponent(arg_1_0._gotopright, gohelper.Type_Animator)
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, arg_2_0.onActivityDungeonMoChange, arg_2_0)
end

function var_0_0.showBtnUI(arg_3_0)
	var_0_0.super.showBtnUI(arg_3_0)
	gohelper.setActive(arg_3_0._goswitchmodecontainer, false)
	arg_3_0._topRightAnimator:Play("open")
end

function var_0_0.hideBtnUI(arg_4_0)
	var_0_0.super.hideBtnUI(arg_4_0)
	gohelper.setActive(arg_4_0._goswitchmodecontainer, false)
	arg_4_0._topRightAnimator:Play("close")
end

function var_0_0.refreshMask(arg_5_0)
	local var_5_0 = VersionActivity2_9DungeonHelper.isAttachedEpisode(arg_5_0.activityDungeonMo.episodeId)

	gohelper.setActive(arg_5_0._simagenormalmask.gameObject, not var_5_0)
	gohelper.setActive(arg_5_0._simagehardmask.gameObject, var_5_0)
end

function var_0_0.onActivityDungeonMoChange(arg_6_0)
	arg_6_0:refreshMask()
end

return var_0_0
