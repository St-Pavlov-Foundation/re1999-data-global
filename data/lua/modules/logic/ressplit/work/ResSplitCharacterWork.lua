module("modules.logic.ressplit.work.ResSplitCharacterWork", package.seeall)

local var_0_0 = class("ResSplitCharacterWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SkinConfig.instance:getAllSkinCoList()
	local var_1_1 = lua_monster_skin.configList
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		table.insert(var_1_2, iter_1_1)
	end

	for iter_1_2, iter_1_3 in pairs(var_1_1) do
		table.insert(var_1_2, iter_1_3)
	end

	for iter_1_4, iter_1_5 in pairs(var_1_2) do
		if ResSplitModel.instance:isExcludeCharacter(iter_1_5.characterId) and ResSplitModel.instance:isExcludeSkin(iter_1_5.id) then
			arg_1_0:_addSkinRes(iter_1_5, true)
		else
			arg_1_0:_addSkinRes(iter_1_5, false)
		end
	end

	local var_1_3 = HeroConfig.instance.heroConfig.configDict

	for iter_1_6, iter_1_7 in pairs(var_1_3) do
		local var_1_4 = ResSplitModel.instance:isExcludeCharacter(iter_1_6)

		if ResSplitModel.instance:isExcludeCharacter(iter_1_6) then
			local var_1_5 = CharacterDataConfig.instance:getCharacterVoicesCo(iter_1_6)

			if var_1_5 then
				for iter_1_8, iter_1_9 in pairs(var_1_5) do
					local var_1_6 = ResSplitModel.instance.audioDic[iter_1_8]

					if var_1_6 then
						ResSplitModel.instance:setExclude(ResSplitEnum.AudioBank, var_1_6.bankName, true)
					end
				end
			end
		else
			local var_1_7 = FightHelper.buildSkills(iter_1_6)

			for iter_1_10, iter_1_11 in ipairs(var_1_7) do
				ResSplitModel.instance:addIncludeSkill(iter_1_11)
			end
		end

		local var_1_8 = ResUrl.getSignature(iter_1_7.signature)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_1_8, var_1_4)
	end

	arg_1_0:onDone(true)
end

function var_0_0._addSkinRes(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = string.format("skin:%d", arg_2_1.id)
	local var_2_1 = ResUrl.getHeadSkinSmall(arg_2_1.id)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_1, arg_2_2)

	local var_2_2 = ResUrl.getHandbookheroIcon(arg_2_1.id)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_2, arg_2_2)

	local var_2_3 = ResUrl.getHeadIconImg(arg_2_1.drawing)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_3, arg_2_2)
	ResSplitHelper.checkConfigEmpty(var_2_0, "headIcon", arg_2_1.headIcon)

	local var_2_4 = ResUrl.getHeadIconSmall(arg_2_1.headIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_4, false)

	local var_2_5 = ResUrl.getHeadIconMiddle(arg_2_1.retangleIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_5, arg_2_2)

	local var_2_6 = ResUrl.getHeadIconSmall(arg_2_1.retangleIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_6, false)

	local var_2_7 = ResUrl.getHeadIconLarge(arg_2_1.retangleIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_7, arg_2_2)

	local var_2_8 = ResUrl.getHeadIconLarge(arg_2_1.largeIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_8, arg_2_2)

	local var_2_9 = ResUrl.getHeadSkinIconMiddle(arg_2_1.skinGetIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_9, arg_2_2)

	local var_2_10 = ResUrl.getHeadSkinIconLarge(arg_2_1.skinGetBackIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_10, arg_2_2)

	local var_2_11 = ResUrl.getLightLive2dFolder(arg_2_1.live2d)

	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, var_2_11, arg_2_2)

	local var_2_12 = arg_2_1.live2dbg

	if not string.nilorempty(var_2_12) then
		local var_2_13 = ResUrl.getCharacterSkinLive2dBg(var_2_12)

		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, var_2_13, arg_2_2)
	end

	local var_2_14 = ResUrl.getRolesPrefabStoryFolder(arg_2_1.verticalDrawing)
	local var_2_15 = string.sub(var_2_14, 1, string.len(var_2_14) - 1)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_15, arg_2_2)

	local var_2_16 = string.split(arg_2_1.spine, "/")
	local var_2_17 = string.format("roles/%s/", var_2_16[1])

	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, var_2_17, arg_2_2)

	local var_2_18 = string.split(arg_2_1.alternateSpine, "/")
	local var_2_19 = string.format("roles/%s/", var_2_18[1])

	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, var_2_19, arg_2_2)

	local var_2_20 = lua_character_limited.configDict[arg_2_1.id]

	if var_2_20 and not string.nilorempty(var_2_20.entranceMv) then
		ResSplitModel.instance:setExclude(ResSplitEnum.Video, var_2_20.entranceMv, true)
	end

	if arg_2_2 == false then
		FightConfig.instance:_checkskinSkill()

		local var_2_21 = FightConfig.instance._skinSkillTLDict[arg_2_1.id]

		if var_2_21 then
			for iter_2_0, iter_2_1 in pairs(var_2_21) do
				ResSplitModel.instance:addIncludeTimeline(iter_2_1)
			end
		end
	end
end

return var_0_0
