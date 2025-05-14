module("modules.logic.player.view.PlayerBgComp", package.seeall)

local var_0_0 = class("PlayerBgComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gobg = gohelper.findChild(arg_1_1, "#go_bg")
	arg_1_0._gospine = gohelper.findChild(arg_1_1, "#go_spine")
	arg_1_0._gospine2 = gohelper.findChild(arg_1_1, "dynamiccontainer/#go_spine")
	arg_1_0._black = gohelper.findChild(arg_1_1, "#go_black")
	arg_1_0._uiSpine = GuiSpine.Create(arg_1_0._gospine, true)
	arg_1_0._uiSpine2 = GuiModelAgent.Create(arg_1_0._gospine2, true)
	arg_1_0._bgLoader = PrefabInstantiate.Create(arg_1_0._gobg)
end

function var_0_0.showBg(arg_2_0, arg_2_1)
	arg_2_0._bgCo = arg_2_1

	arg_2_0:_loadSpine()

	local var_2_0 = arg_2_0._bgLoader:getPath()
	local var_2_1 = string.format("ui/viewres/player/bg/%s.prefab", arg_2_1.bgEffect)

	if var_2_0 ~= var_2_1 then
		arg_2_0._bgLoader:dispose()
		arg_2_0._bgLoader:startLoad(var_2_1)
	end

	gohelper.setActive(arg_2_0._black, arg_2_1.item ~= 0)
end

function var_0_0.setPlayerInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._otherPlayerInfo = arg_3_1
	arg_3_0._otherPlayerHeroCover = arg_3_2
end

function var_0_0._loadSpine(arg_4_0)
	gohelper.setActive(arg_4_0._gospine, arg_4_0._bgCo.item == 0)
	gohelper.setActive(arg_4_0._gospine2, arg_4_0._bgCo.item ~= 0)

	if arg_4_0._bgCo.item == 0 then
		local var_4_0 = CommonConfig.instance:getConstStr(ConstEnum.PlayerViewSpine)
		local var_4_1 = ResUrl.getRolesCgStory(var_4_0)

		if arg_4_0._uiSpine:getResPath() ~= var_4_1 then
			arg_4_0._uiSpine:setResPath(var_4_1, arg_4_0._onSpineLoaded, arg_4_0)
		end
	else
		local var_4_2

		if arg_4_0._otherPlayerHeroCover then
			local var_4_3 = string.splitToNumber(arg_4_0._otherPlayerHeroCover, "#")
			local var_4_4 = var_4_3[1]
			local var_4_5 = var_4_3[2]

			var_4_2 = lua_skin.configDict[var_4_5]

			if not var_4_2 then
				local var_4_6 = lua_character.configDict[var_4_4] or lua_character.configDict[3028]

				var_4_2 = lua_skin[var_4_6.skinId]
			end
		else
			local var_4_7, var_4_8 = CharacterSwitchListModel.instance:getMainHero()
			local var_4_9 = HeroModel.instance:getByHeroId(var_4_7)

			var_4_2 = SkinConfig.instance:getSkinCo(var_4_8 or var_4_9 and var_4_9.skin)
		end

		if var_4_2 == arg_4_0._nowSkinCo then
			return
		end

		arg_4_0._nowSkinCo = var_4_2

		arg_4_0._uiSpine2:setResPath(var_4_2, arg_4_0._onSpineLoaded2, arg_4_0)

		local var_4_10 = SkinConfig.instance:getSkinOffset(var_4_2.characterViewOffset)

		recthelper.setAnchor(arg_4_0._gospine2.transform, tonumber(var_4_10[1]), tonumber(var_4_10[2]))
		transformhelper.setLocalScale(arg_4_0._gospine2.transform, tonumber(var_4_10[3]), tonumber(var_4_10[3]), tonumber(var_4_10[3]))
	end
end

function var_0_0._onSpineLoaded(arg_5_0)
	arg_5_0._uiSpine:changeLookDir(SpineLookDir.Left)

	local var_5_0 = arg_5_0._otherPlayerInfo or PlayerModel.instance:getPlayinfo()
	local var_5_1 = CommonConfig.instance:getConstNum(ConstEnum.PlayerViewEyeEpisodeId)

	if var_5_1 == var_5_0.lastEpisodeId or DungeonConfig.instance:isPreEpisodeList(var_5_1, var_5_0.lastEpisodeId) then
		arg_5_0._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "b_idle", true, 0)
	else
		arg_5_0._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "b_idle_1", true, 0)
	end
end

function var_0_0._onSpineLoaded2(arg_6_0)
	arg_6_0._uiSpine2:setModelVisible(true)
end

function var_0_0.onDestroy(arg_7_0)
	if arg_7_0._uiSpine then
		gohelper.destroy(arg_7_0._gospine)

		arg_7_0._gospine = nil
		arg_7_0._uiSpine = nil
	end

	if arg_7_0._bgLoader then
		arg_7_0._bgLoader:dispose()

		arg_7_0._bgLoader = nil
	end
end

return var_0_0
