module("modules.logic.ressplit.work.ResSplitSkillWork", package.seeall)

local var_0_0 = class("ResSplitSkillWork", BaseWork)
local var_0_1 = {
	"FightTLEventTargetEffect",
	nil,
	nil,
	nil,
	"FightTLEventAtkEffect",
	"FightTLEventAtkFlyEffect",
	"FightTLEventAtkFullEffect",
	"FightTLEventDefEffect",
	[28] = "FightTLEventDefEffect"
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0.includeTimeLineDic = {}

	local var_1_0 = ResSplitModel.instance:getIncludeSkill()

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		local var_1_1 = lua_skill.configDict[iter_1_0]

		if var_1_1 then
			arg_1_0.includeTimeLineDic[ResUrl.getSkillTimeline(var_1_1.timeline)] = true
		end
	end

	local var_1_2 = ResSplitModel.instance:getIncludeTimelineDic()

	for iter_1_2, iter_1_3 in pairs(var_1_2) do
		arg_1_0.includeTimeLineDic[ResUrl.getSkillTimeline(iter_1_2)] = true
	end

	local var_1_3 = SLFramework.FileHelper.GetDirFilePaths("Assets/ZResourcesLib/rolestimeline")

	arg_1_0._loader = MultiAbLoader.New()

	local var_1_4 = {}

	for iter_1_4 = 0, var_1_3.Length - 1 do
		local var_1_5 = var_1_3[iter_1_4]

		if not string.find(var_1_5, ".meta") then
			local var_1_6 = SLFramework.FileHelper.GetFileName(var_1_5, true)

			arg_1_0._loader:addPath(string.lower("rolestimeline/" .. var_1_6))
		end
	end

	arg_1_0._loader:startLoad(arg_1_0._dealSkillTimeLine, arg_1_0)
end

function var_0_0._dealSkillTimeLine(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._loader._resList) do
		local var_2_0 = ZProj.SkillTimelineAssetHelper.GeAssetJson(iter_2_1)

		if not string.nilorempty(var_2_0) then
			local var_2_1 = cjson.decode(var_2_0)

			for iter_2_2 = 1, #var_2_1, 2 do
				local var_2_2 = tonumber(var_2_1[iter_2_2])
				local var_2_3 = var_2_1[iter_2_2 + 1][1]

				if var_0_1[var_2_2] and not ResSplitHelper.checkConfigEmpty(string.format("SkillTimeLine:%s", iter_2_1.ResPath), var_2_2, var_2_3) then
					local var_2_4 = FightHelper.getEffectUrlWithLod(var_2_3)
					local var_2_5 = ResSplitEnum.Folder
					local var_2_6 = var_2_4

					if string.find(var_2_4, "effects/prefabs/buff/") or string.find(var_2_4, "effects/prefabs/story/") then
						var_2_5 = ResSplitEnum.Path
					else
						local var_2_7 = SLFramework.FileHelper.GetFileName(var_2_4, true)

						var_2_6 = string.gsub(var_2_4, "/" .. var_2_7, "")
					end

					if arg_2_0.includeTimeLineDic[iter_2_1.ResPath] then
						ResSplitModel.instance:setExclude(var_2_5, var_2_6, false)
					else
						ResSplitModel.instance:setExclude(var_2_5, var_2_6, true)
					end
				elseif var_2_2 == 16 and not ResSplitHelper.checkConfigEmpty(string.format("SkillTimeLine:%s", iter_2_1.ResPath), var_2_2, var_2_3) then
					local var_2_8 = ResUrl.getVideo(var_2_3)

					if arg_2_0.includeTimeLineDic[iter_2_1.ResPath] then
						ResSplitModel.instance:setExclude(ResSplitEnum.Video, var_2_3, false)
					else
						ResSplitModel.instance:setExclude(ResSplitEnum.Video, var_2_3, true)
					end
				end
			end
		end
	end

	arg_2_0:onDone(true)
end

return var_0_0
