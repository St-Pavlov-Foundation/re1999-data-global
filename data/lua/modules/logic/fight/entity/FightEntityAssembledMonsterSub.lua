module("modules.logic.fight.entity.FightEntityAssembledMonsterSub", package.seeall)

local var_0_0 = class("FightEntityAssembledMonsterSub", FightEntityMonster)

function var_0_0.getScale(arg_1_0)
	return arg_1_0.mainEntity:getScale()
end

function var_0_0.setScale(arg_2_0, arg_2_1)
	arg_2_0.mainEntity:setScale(arg_2_1)
end

function var_0_0.getHangPoint(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_2 and not string.nilorempty(arg_3_1) and ModuleEnum.SpineHangPointRoot ~= arg_3_1 then
		arg_3_1 = string.format("%s_part_%d", arg_3_1, arg_3_0:getPartIndex())
	end

	return var_0_0.super.getHangPoint(arg_3_0, arg_3_1)
end

function var_0_0.resetAnimState(arg_4_0)
	arg_4_0.mainEntity:resetAnimState()
end

function var_0_0.setAlpha(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.mainEntity:setAlphaData(arg_5_0.id, arg_5_1, arg_5_2)
end

function var_0_0.loadSpine(arg_6_0)
	return
end

function var_0_0.getMainEntityId(arg_7_0)
	if arg_7_0.mainEntityId then
		return arg_7_0.mainEntityId
	end

	local var_7_0
	local var_7_1 = FightDataHelper.entityMgr:getEnemyNormalList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = lua_fight_assembled_monster.configDict[iter_7_1.skin]

		if var_7_2 and var_7_2.part == 1 then
			var_7_0 = iter_7_1.id

			break
		end
	end

	if not var_7_0 then
		logError("构建组合怪部件,但是没有找到主怪")

		return
	end

	arg_7_0.mainEntityId = var_7_0

	return arg_7_0.mainEntityId
end

function var_0_0.getMainEntity(arg_8_0)
	arg_8_0.mainEntity = arg_8_0.mainEntity or FightHelper.getEntity(arg_8_0.mainEntityId)

	return arg_8_0.mainEntity
end

function var_0_0.initComponents(arg_9_0)
	if not arg_9_0:getMainEntityId() then
		return
	end

	arg_9_0:getMainEntity()

	arg_9_0.filterComp = {
		moveHandler = true,
		curveMover = true,
		spineRenderer = true,
		spine = true,
		parabolaMover = true,
		mover = true,
		bezierMover = true
	}

	local var_9_0 = FightHelper.getEntity(arg_9_0.mainEntityId)

	arg_9_0.mainSpine = var_9_0.spine
	arg_9_0.spine = FightAssembledMonsterSpineSub.New(arg_9_0)
	arg_9_0.spineRenderer = var_9_0.spineRenderer
	arg_9_0.mover = var_9_0.mover
	arg_9_0.parabolaMover = var_9_0.parabolaMover
	arg_9_0.bezierMover = var_9_0.bezierMover
	arg_9_0.curveMover = var_9_0.curveMover
	arg_9_0.moveHandler = var_9_0.moveHandler

	var_0_0.super.initComponents(arg_9_0)
end

function var_0_0.getPartIndex(arg_10_0)
	local var_10_0 = arg_10_0:getMO()

	if var_10_0 then
		return lua_fight_assembled_monster.configDict[var_10_0.skin].part
	end
end

return var_0_0
