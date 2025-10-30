module("modules.logic.fight.entity.comp.FightHpKillLineComp", package.seeall)

local var_0_0 = class("FightHpKillLineComp", UserDataDispose)

var_0_0.resPath = "ui/viewres/fight/fightkilllineview.prefab"
var_0_0.LoadStatus = {
	Loaded = 2,
	NotLoaded = 0,
	Loading = 1
}

local var_0_1 = var_0_0.LoadStatus

var_0_0.KillLineType = {
	NameUiHp = 3,
	BossHp = 1,
	FocusHp = 2
}
var_0_0.LineType2NodeName = {
	[var_0_0.KillLineType.BossHp] = "boss_hp",
	[var_0_0.KillLineType.FocusHp] = "focus_hp",
	[var_0_0.KillLineType.NameUiHp] = "name_ui_hp"
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.lineType = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:__onInit()

	arg_2_0.loadStatus = var_0_1.NotLoaded
	arg_2_0.containerGo = arg_2_2
	arg_2_0.containerWidth = recthelper.getWidth(arg_2_0.containerGo:GetComponent(gohelper.Type_RectTransform))
	arg_2_0.entityId = arg_2_1
	arg_2_0.entityMo = FightDataHelper.entityMgr:getById(arg_2_0.entityId)

	arg_2_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_2_0.onBuffUpdate, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.UpdateBuffActInfo, arg_2_0.onUpdateBuffActInfo, arg_2_0)
	arg_2_0:checkNeedLoadRes()
end

function var_0_0.checkNeedLoadRes(arg_3_0)
	if arg_3_0.entityMo and arg_3_0.entityMo:hasBuffFeature(FightEnum.BuffType_RealDamageKill) then
		arg_3_0:loadRes()
	end
end

function var_0_0.onUpdateBuffActInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 ~= arg_4_0.entityId then
		return
	end

	if not arg_4_0.entityMo then
		return
	end

	local var_4_0 = arg_4_0.entityMo:getBuffDic()
	local var_4_1 = var_4_0 and var_4_0[arg_4_2]

	if not var_4_1 then
		return
	end

	if not arg_4_0:checkIsKillBuff(var_4_1.buffId) then
		return
	end

	arg_4_0:updateKillLine()
end

function var_0_0.onBuffUpdate(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	if arg_5_1 ~= arg_5_0.entityId then
		return
	end

	if not arg_5_0:checkIsKillBuff(arg_5_3) then
		return
	end

	if arg_5_2 == FightEnum.EffectType.BUFFADD then
		arg_5_0:addKillLine()
	elseif arg_5_2 == FightEnum.EffectType.BUFFDEL or arg_5_2 == FightEnum.EffectType.BUFFDELNOEFFECT then
		arg_5_0:updateKillLine()
	elseif arg_5_2 == FightEnum.EffectType.BUFFUPDATE then
		arg_5_0:updateKillLine()
	end
end

function var_0_0.checkIsKillBuff(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.entityMo:getFeaturesSplitInfoByBuffId(arg_6_1)

	if not var_6_0 then
		return false
	end

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = lua_buff_act.configDict[iter_6_1[1]]

		if var_6_1 and var_6_1.type == FightEnum.BuffType_RealDamageKill then
			return true
		end
	end

	return false
end

function var_0_0.addKillLine(arg_7_0)
	if arg_7_0.loadStatus == var_0_1.Loaded then
		return arg_7_0:updateKillLine()
	end

	if arg_7_0.loadStatus == var_0_1.Loading then
		return
	end

	arg_7_0:loadRes()
end

function var_0_0.updateKillLine(arg_8_0)
	if arg_8_0.loadStatus ~= var_0_1.Loaded then
		return
	end

	gohelper.setActive(arg_8_0.killLineGo, false)

	if arg_8_0.entityMo then
		local var_8_0 = arg_8_0.entityMo:getBuffDic()

		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			if arg_8_0:checkIsKillBuff(iter_8_1.buffId) then
				local var_8_1 = iter_8_1.actInfo

				for iter_8_2, iter_8_3 in ipairs(var_8_1) do
					if iter_8_3.actId == FightEnum.BuffActId.RealDamageKill then
						return arg_8_0:_updateKillLine(iter_8_3.strParam)
					end
				end
			end
		end
	end
end

function var_0_0._updateKillLine(arg_9_0, arg_9_1)
	if not arg_9_0.entityMo then
		return
	end

	gohelper.setActive(arg_9_0.killLineGo, true)

	arg_9_1 = tonumber(arg_9_1)

	local var_9_0 = arg_9_1 / arg_9_0.entityMo.attrMO.hp * arg_9_0.containerWidth

	recthelper.setAnchorX(arg_9_0.rectKillLine, var_9_0)
end

function var_0_0.loadRes(arg_10_0)
	arg_10_0.loadStatus = var_0_1.Loading
	arg_10_0.loader = PrefabInstantiate.Create(arg_10_0.containerGo)

	arg_10_0.loader:startLoad(var_0_0.resPath, arg_10_0.onResLoaded, arg_10_0)
end

function var_0_0.onResLoaded(arg_11_0)
	arg_11_0.loadStatus = var_0_1.Loaded
	arg_11_0.killLineGo = arg_11_0.loader:getInstGO()
	arg_11_0.rectKillLine = arg_11_0.killLineGo:GetComponent(gohelper.Type_RectTransform)

	for iter_11_0, iter_11_1 in pairs(var_0_0.KillLineType) do
		local var_11_0 = gohelper.findChild(arg_11_0.killLineGo, var_0_0.LineType2NodeName[iter_11_1])
		local var_11_1 = arg_11_0.lineType == iter_11_1

		gohelper.setActive(var_11_0, var_11_1)

		if var_11_1 then
			local var_11_2 = var_11_0:GetComponent(gohelper.Type_RectTransform)
			local var_11_3 = recthelper.getWidth(var_11_2)
			local var_11_4 = recthelper.getHeight(var_11_2)

			recthelper.setSize(arg_11_0.rectKillLine, var_11_3, var_11_4)
		end
	end

	arg_11_0:updateKillLine()
end

function var_0_0.removeKillLine(arg_12_0)
	if arg_12_0.loader then
		arg_12_0.loader:onDestroy()

		arg_12_0.loader = nil
	end

	if arg_12_0.killLineGo then
		gohelper.destroy(arg_12_0.killLineGo)

		arg_12_0.killLineGo = nil
	end

	arg_12_0.loadStatus = var_0_1.NotLoaded
end

function var_0_0.beforeDestroy(arg_13_0)
	arg_13_0:destroy()
end

function var_0_0.destroy(arg_14_0)
	arg_14_0:removeKillLine()
	arg_14_0:__onDispose()
end

return var_0_0
