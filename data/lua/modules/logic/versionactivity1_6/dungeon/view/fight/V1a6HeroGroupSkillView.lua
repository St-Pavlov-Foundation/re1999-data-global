module("modules.logic.versionactivity1_6.dungeon.view.fight.V1a6HeroGroupSkillView", package.seeall)

local var_0_0 = class("V1a6HeroGroupSkillView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gototem = gohelper.findChild(arg_1_0.viewGO, "#go_totem")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SwitchReplay, arg_2_0.switchReplay, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.PrefabPath = "ui/viewres/herogroup/herogroupviewtalent.prefab"

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = FightModel.instance:getFightParam().chapterId
	local var_4_1 = false

	if var_4_0 == VersionActivity1_6DungeonEnum.DungeonChapterId.Story1 or var_4_0 == VersionActivity1_6DungeonEnum.DungeonChapterId.Story2 or var_4_0 == VersionActivity1_6DungeonEnum.DungeonChapterId.Story3 or var_4_0 == VersionActivity1_6DungeonEnum.DungeonChapterId.Story4 or var_4_0 == VersionActivity1_6DungeonEnum.DungeonChapterId.ElementFight or var_4_0 == VersionActivity1_6DungeonEnum.DungeonChapterId.BossFight then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101) then
			return
		end

		var_4_1 = true
	end

	if not var_4_1 then
		return
	end

	arg_4_0.loader = PrefabInstantiate.Create(arg_4_0._gototem)

	arg_4_0.loader:startLoad(var_0_0.PrefabPath, arg_4_0.onLoadFinish, arg_4_0)
end

function var_0_0.onLoadFinish(arg_5_0)
	arg_5_0.loadFinishDone = true
	arg_5_0.go = arg_5_0.loader:getInstGO()
	arg_5_0._singleBg = gohelper.findChildSingleImage(arg_5_0.go, "#go_Talent/Talent/image_TalentIcon")
	arg_5_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_5_0.go, "#go_Talent/#btn_click")

	arg_5_0._btnclick:AddClickListener(arg_5_0._btnClickOnClick, arg_5_0)
	arg_5_0:refreshPoint()
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_5_0.onCloseViewFinish, arg_5_0)
end

function var_0_0.onReceiveMsg(arg_6_0)
	arg_6_0.receiveMsgDone = true

	arg_6_0:refreshPoint()
end

function var_0_0.refreshPoint(arg_7_0)
	if not arg_7_0.loadFinishDone then
		return
	end

	gohelper.setActive(arg_7_0._gototem, true)
end

function var_0_0.switchReplay(arg_8_0, arg_8_1)
	arg_8_0.isReplay = arg_8_1

	arg_8_0:refreshPoint()
end

function var_0_0._btnClickOnClick(arg_9_0)
	if arg_9_0.isReplay then
		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6SkillView)
end

function var_0_0.onCloseViewFinish(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0._btnclick then
		arg_11_0._btnclick:RemoveClickListener()
	end

	if arg_11_0._singleBg then
		arg_11_0._singleBg:UnLoadImage()
	end

	if arg_11_0.loader then
		arg_11_0.loader:dispose()
	end
end

return var_0_0
