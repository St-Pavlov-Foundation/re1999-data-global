module("modules.logic.bossrush.view.v2a9.V2a9_BossRushHeroGroupSkillComp", package.seeall)

local var_0_0 = class("V2a9_BossRushHeroGroupSkillComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.root = gohelper.findChild(arg_1_0.viewGO, "fightassassinwheelview/Root")
	arg_1_0._txtskillTitle = gohelper.findChildText(arg_1_0.viewGO, "fightassassinwheelview/Root/Image_skillBG/#txt_skillTitle")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onLoadingCloseView, arg_2_0, LuaEventSystem.High)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onLoadingCloseView, arg_3_0, LuaEventSystem.High)
end

function var_0_0._onReceiveAct128SpFirstHalfSelectItemReply(arg_4_0)
	arg_4_0:refreshView()
end

function var_0_0._onLoadingCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.V2a9_BossRushSkillBackpackView then
		if arg_5_0._skillitems then
			local var_5_0 = V2a9BossRushModel.instance:getAllEquipMos(arg_5_0._stage)

			for iter_5_0 = 1, BossRushEnum.V2a9FightEquipSkillMaxCount do
				local var_5_1 = var_5_0[iter_5_0] and var_5_0[iter_5_0]:getItemType()
				local var_5_2 = arg_5_0:_getSkillItem(iter_5_0)

				if var_5_1 then
					if arg_5_0._equidItemTypes[iter_5_0] then
						if var_5_1 ~= arg_5_0._equidItemTypes[iter_5_0] then
							var_5_2:playAnim(BossRushEnum.S01Anim.Load)
						end
					else
						var_5_2:playAnim(BossRushEnum.S01Anim.Load)
					end
				elseif arg_5_0._equidItemTypes[iter_5_0] then
					var_5_2:playAnim(BossRushEnum.S01Anim.Unload)
				end
			end
		end

		arg_5_0:refreshView()
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._skillitemroot = gohelper.findChild(arg_6_0.root, "simage_wheel")
	arg_6_0._skillitemPrefab = gohelper.findChild(arg_6_0.root, "simage_wheel/go_skillitem")

	gohelper.setActive(arg_6_0._skillitemPrefab, false)

	arg_6_0._skillitems = arg_6_0:getUserDataTb_()
	arg_6_0._txtskillTitle.text = luaLang("bossrush_skillcomp_title")
end

function var_0_0.onUpdateMO(arg_7_0)
	local var_7_0 = HeroGroupModel.instance.episodeId

	arg_7_0._stage = BossRushConfig.instance:getEpisodeCoByEpisodeId(var_7_0).stage

	local var_7_1 = AssassinOutsideModel.instance:getAct195Id()

	AssassinOutSideRpc.instance:sendGetAssassinOutSideInfoRequest(var_7_1, arg_7_0._refreshModel, arg_7_0)
end

function var_0_0._refreshModel(arg_8_0)
	AssassinBackpackListModel.instance:setAssassinBackpackList()
	V2a9BossRushSkillBackpackListModel.instance:setMoList(arg_8_0._stage)
	arg_8_0:refreshView()
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0._equidItemTypes = {}

	local var_9_0 = V2a9BossRushModel.instance:getAllEquipMos(arg_9_0._stage)
	local var_9_1 = 1

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			arg_9_0:_getSkillItem(var_9_1):onUpdateMO(iter_9_1)

			var_9_1 = var_9_1 + 1
			arg_9_0._equidItemTypes[iter_9_1:getIndex()] = iter_9_1:getItemType()
		end
	end

	if arg_9_0._skillitems then
		for iter_9_2 = 1, #arg_9_0._skillitems do
			gohelper.setActive(arg_9_0._skillitems[iter_9_2].viewGO, iter_9_2 < var_9_1)
		end
	end
end

function var_0_0._getSkillItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._skillitems[arg_10_1]

	if not var_10_0 then
		local var_10_1 = gohelper.findChild(arg_10_0._skillitemroot, arg_10_1 .. "/go_item")
		local var_10_2 = gohelper.clone(arg_10_0._skillitemPrefab, var_10_1)

		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_2, V2a9_BossRushHeroGroupSkillCompItem)
		arg_10_0._skillitems[arg_10_1] = var_10_0
	end

	return var_10_0
end

return var_0_0
