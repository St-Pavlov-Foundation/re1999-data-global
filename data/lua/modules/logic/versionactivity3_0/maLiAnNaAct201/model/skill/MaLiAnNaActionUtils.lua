module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaActionUtils", package.seeall)

local var_0_0 = class("MaLiAnNaActionUtils")

function var_0_0.ctor(arg_1_0)
	arg_1_0._defineList = {
		[Activity201MaLiAnNaEnum.SkillAction.addSlotSolider] = var_0_0._addSlotSolider,
		[Activity201MaLiAnNaEnum.SkillAction.removeSlotSolider] = var_0_0._removeSlotSolider,
		[Activity201MaLiAnNaEnum.SkillAction.moveSlotSolider] = var_0_0._moveSlotSolider,
		[Activity201MaLiAnNaEnum.SkillAction.pauseSlotGenerateSolider] = var_0_0._pauseSlotGenerateSolider,
		[Activity201MaLiAnNaEnum.SkillAction.releaseBullet] = var_0_0._releaseBullet,
		[Activity201MaLiAnNaEnum.SkillAction.killSolider] = var_0_0._killSolider
	}
end

function var_0_0._addSlotSolider(arg_2_0, arg_2_1)
	if arg_2_0 == nil or arg_2_1 == nil then
		return
	end

	local var_2_0 = arg_2_0[1]

	if var_2_0 == nil then
		return
	end

	local var_2_1 = tonumber(arg_2_1[2]) or 1
	local var_2_2 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_2_0)

	if var_2_2 then
		var_2_2:skillToCreateSolider(var_2_1, Activity201MaLiAnNaEnum.CampType.Player)

		if isDebugBuild then
			logNormal("添加槽位士兵：" .. var_2_2:getConfig().baseId .. " 数量：" .. var_2_1)
		end
	end
end

function var_0_0._removeSlotSolider(arg_3_0, arg_3_1)
	if arg_3_0 == nil or arg_3_1 == nil then
		return
	end

	local var_3_0 = arg_3_0[1]

	if var_3_0 == nil then
		return
	end

	local var_3_1 = tonumber(arg_3_1[2]) or 1
	local var_3_2 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_3_0)

	if var_3_2 then
		var_3_2:skillToRemoveSolider(var_3_1, Activity201MaLiAnNaEnum.CampType.Enemy)

		if isDebugBuild then
			logNormal("移除槽位士兵：" .. var_3_2:getConfig().baseId .. " 数量：" .. var_3_1)
		end
	end
end

function var_0_0._moveSlotSolider(arg_4_0, arg_4_1)
	if arg_4_0 == nil or arg_4_1 == nil then
		return
	end

	local var_4_0 = arg_4_0[1]
	local var_4_1 = arg_4_0[2]

	if var_4_0 == nil or var_4_1 == nil then
		return
	end

	local var_4_2 = tonumber(arg_4_1[2]) or 1
	local var_4_3 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_4_0)
	local var_4_4 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_4_1)
	local var_4_5 = var_4_3:getSoliderCount()
	local var_4_6 = math.min(var_4_2, var_4_5 - 1)

	if var_4_3 and var_4_4 then
		for iter_4_0 = 1, var_4_6 do
			local var_4_7 = var_4_3:getAndRemoveNormalSolider()

			if var_4_7 then
				var_4_4:enterSoldier(var_4_7, true)
			end
		end

		if isDebugBuild then
			logNormal("转移士兵【1->2】：" .. var_4_3:getConfig().baseId .. " -> " .. var_4_4:getConfig().baseId)
		end
	end
end

function var_0_0._pauseSlotGenerateSolider(arg_5_0, arg_5_1)
	if arg_5_0 == nil or arg_5_1 == nil then
		return
	end

	local var_5_0 = arg_5_0[1]

	if var_5_0 == nil then
		return
	end

	local var_5_1 = tonumber(arg_5_1[2]) or 1
	local var_5_2 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_5_0)

	if var_5_2 then
		var_5_2:setSkillGenerateSoliderEffectTime(var_5_1)

		if isDebugBuild then
			logNormal("干扰生成和出兵：" .. var_5_2:getConfig().baseId)
		end
	end
end

local var_0_1 = {}

function var_0_0._releaseBullet(arg_6_0, arg_6_1)
	if arg_6_0 == nil or arg_6_1 == nil then
		return
	end

	if isDebugBuild then
		logNormal("触发狙杀：")
	end

	local var_6_0 = arg_6_0[1]
	local var_6_1 = arg_6_1[3]
	local var_6_2 = arg_6_1[4]
	local var_6_3 = tonumber(arg_6_1[5]) or 1
	local var_6_4 = MaLiAnNaLaSoliderMoUtil.instance:getSoliderMoById(var_6_0)

	if var_6_4 == nil then
		return
	end

	local var_6_5 = var_6_4:getCamp()
	local var_6_6 = Activity201MaLiAnNaEnum.CampType.Enemy

	if var_6_5 == Activity201MaLiAnNaEnum.CampType.Enemy then
		var_6_6 = Activity201MaLiAnNaEnum.CampType.Player
	end

	local var_6_7, var_6_8 = var_6_4:getLocalPos()
	local var_6_9 = var_0_0._findSolider(var_6_7, var_6_8, var_6_1, var_6_6)

	if var_6_9 ~= nil then
		local var_6_10 = MaliAnNaBulletEntityMgr.instance:getBulletEffectEntity()

		if var_6_10 ~= nil then
			local var_6_11, var_6_12 = var_6_4:getBulletPos()

			if var_6_11 == nil or var_6_12 == nil then
				var_6_11, var_6_12 = var_6_4:getLocalPos()
			end

			var_6_10:setInfo(var_6_11, var_6_12, var_6_9, var_6_3, var_6_2, true)

			if isDebugBuild then
				logNormal("实行狙杀：")
			end

			return
		end
	end
end

function var_0_0._killSolider(arg_7_0, arg_7_1)
	if arg_7_0 == nil or arg_7_1 == nil then
		return
	end

	local var_7_0 = arg_7_1[2]
	local var_7_1 = arg_7_1[4] or 1
	local var_7_2 = arg_7_0[1]
	local var_7_3 = arg_7_0[2]
	local var_7_4 = arg_7_0[3]
	local var_7_5 = var_0_0._findSolider(var_7_2, var_7_3, var_7_0, var_7_4)

	if var_7_5 then
		Activity201MaLiAnNaGameController.instance:consumeSoliderHp(var_7_5, -var_7_1)

		if isDebugBuild then
			logNormal("杀死士兵：")
		end
	end
end

function var_0_0._findSolider(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0

	if var_0_1 ~= nil then
		tabletool.clear(var_0_1)
	end

	local var_8_1 = MaLiAnNaLaSoliderMoUtil.instance:getAllSoliderMoList()

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		if iter_8_1 then
			local var_8_2, var_8_3 = iter_8_1:getLocalPos()

			if iter_8_1:getCamp() == arg_8_3 and MathUtil.isPointInCircleRange(arg_8_0, arg_8_1, arg_8_2, var_8_2, var_8_3) and not iter_8_1:isDead() then
				table.insert(var_0_1, iter_8_1)
			end
		end
	end

	if var_0_1 ~= nil then
		table.sort(var_0_1, function(arg_9_0, arg_9_1)
			local var_9_0, var_9_1 = arg_9_0:getLocalPos()
			local var_9_2, var_9_3 = arg_9_1:getLocalPos()

			return MathUtil.vec2_lengthSqr(arg_8_0, arg_8_1, var_9_0, var_9_1) < MathUtil.vec2_lengthSqr(arg_8_0, arg_8_1, var_9_2, var_9_3)
		end)
	end

	if #var_0_1 > 0 then
		var_8_0 = var_0_1[1]:getId()
	end

	return var_8_0
end

function var_0_0.getHandleFunc(arg_10_0, arg_10_1)
	return arg_10_0._defineList[arg_10_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
