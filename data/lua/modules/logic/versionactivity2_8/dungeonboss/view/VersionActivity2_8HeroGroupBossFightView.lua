module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8HeroGroupBossFightView", package.seeall)

local var_0_0 = class("VersionActivity2_8HeroGroupBossFightView", HeroGroupFightView)

function var_0_0._refreshBtns(arg_1_0, arg_1_1)
	var_0_0.super._refreshBtns(arg_1_0, arg_1_1)
	gohelper.setActive(arg_1_0._dropherogroup, false)
end

function var_0_0._onClickStart(arg_2_0)
	local var_2_0 = string.split(arg_2_0.episodeConfig.cost, "|")
	local var_2_1 = string.split(var_2_0[1], "#")
	local var_2_2 = tonumber(var_2_1[3] or 0)
	local var_2_3 = arg_2_0:_getfreeCount()

	if var_2_2 * ((arg_2_0._multiplication or 1) - var_2_3) > CurrencyModel.instance:getPower() then
		CurrencyController.instance:openPowerView()

		return
	end

	local var_2_4 = 10104

	if HeroGroupModel.instance.episodeId == var_2_4 and not DungeonModel.instance:hasPassLevel(var_2_4) then
		local var_2_5 = HeroSingleGroupModel.instance:getList()
		local var_2_6 = 0

		for iter_2_0, iter_2_1 in ipairs(var_2_5) do
			if not iter_2_1:isEmpty() then
				var_2_6 = var_2_6 + 1
			end
		end

		if var_2_6 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	arg_2_0:_closemultcontent()
	GameFacade.showMessageBox(MessageBoxIdDefine.BossStoryTip1, MsgBoxEnum.BoxType.Yes_No, arg_2_0._enterFight, nil, nil, arg_2_0)
end

function var_0_0._saveHeroGroup(arg_3_0)
	local var_3_0 = HeroGroupModel.instance.episodeId
	local var_3_1 = VersionActivity2_8BossConfig.instance:getHeroGroupId(var_3_0)
	local var_3_2 = var_3_1 and lua_hero_group_type.configDict[var_3_1]
	local var_3_3 = HeroGroupModel.instance:getCurGroupMO()
	local var_3_4 = var_3_3:getMainList()
	local var_3_5 = var_3_3:getSubList()

	HeroGroupModel.instance:updateCustomHeroGroup(var_3_2.id, var_3_3)

	local var_3_6 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(var_3_6.fightGroup, var_3_3.clothId, var_3_4, var_3_5, var_3_3:getAllHeroEquips(), var_3_3:getAllHeroActivity104Equips())
	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Resources, var_3_2.id, var_3_6, callback, callbackObj)
end

function var_0_0._enterFight(arg_4_0)
	if HeroGroupModel.instance.episodeId then
		arg_4_0._closeWithEnteringFight = true

		if FightController.instance:setFightHeroSingleGroup() then
			arg_4_0:_saveHeroGroup()
			arg_4_0.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

			local var_4_0 = FightModel.instance:getFightParam()

			if arg_4_0._replayMode then
				var_4_0.isReplay = true
				var_4_0.multiplication = arg_4_0._multiplication

				DungeonFightController.instance:sendStartDungeonRequest(var_4_0.chapterId, var_4_0.episodeId, var_4_0, arg_4_0._multiplication, nil, true)
			else
				var_4_0.isReplay = false
				var_4_0.multiplication = 1

				DungeonFightController.instance:sendStartDungeonRequest(var_4_0.chapterId, var_4_0.episodeId, var_4_0, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

return var_0_0
