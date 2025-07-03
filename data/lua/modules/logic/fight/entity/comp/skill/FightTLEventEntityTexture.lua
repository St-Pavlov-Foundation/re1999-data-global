module("modules.logic.fight.entity.comp.skill.FightTLEventEntityTexture", package.seeall)

local var_0_0 = class("FightTLEventEntityTexture", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_3[1]

	arg_1_0._targetEntitys = nil

	if var_1_0 == "1" then
		arg_1_0._targetEntitys = {}

		table.insert(arg_1_0._targetEntitys, FightHelper.getEntity(arg_1_1.fromId))
	elseif var_1_0 == "2" then
		arg_1_0._targetEntitys = FightHelper.getSkillTargetEntitys(arg_1_1)
	elseif not string.nilorempty(var_1_0) then
		local var_1_1 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_1_2 = arg_1_1.stepUid .. "_" .. var_1_0
		local var_1_3 = var_1_1:getUnit(SceneTag.UnitNpc, var_1_2)

		if var_1_3 then
			arg_1_0._targetEntitys = {}

			table.insert(arg_1_0._targetEntitys, var_1_3)
		else
			logError("找不到实体, id: " .. tostring(var_1_0))

			return
		end
	end

	arg_1_0._texVariable = arg_1_3[3]

	local var_1_4 = arg_1_3[2]

	if not string.nilorempty(var_1_4) then
		arg_1_0._texturePath = ResUrl.getRoleSpineMatTex(var_1_4)
		arg_1_0._loader = MultiAbLoader.New()

		arg_1_0._loader:addPath(arg_1_0._texturePath)
		arg_1_0._loader:startLoad(arg_1_0._onLoaded, arg_1_0)
	end
end

function var_0_0._onLoaded(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getFirstAssetItem()
	local var_2_1 = var_2_0 and var_2_0:GetResource(arg_2_0._texturePath)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._targetEntitys) do
		iter_2_1.spineRenderer:getReplaceMat():SetTexture(arg_2_0._texVariable, var_2_1)
	end
end

function var_0_0._clear(arg_3_0)
	if not arg_3_0._loader then
		return
	end

	arg_3_0._loader:dispose()

	arg_3_0._loader = nil

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._targetEntitys) do
		iter_3_1.spineRenderer:getReplaceMat():SetTexture(arg_3_0._texVariable, nil)
	end
end

function var_0_0.onDestructor(arg_4_0)
	arg_4_0:_clear()
end

return var_0_0
