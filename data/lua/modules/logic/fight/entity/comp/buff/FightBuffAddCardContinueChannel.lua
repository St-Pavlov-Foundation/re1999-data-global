module("modules.logic.fight.entity.comp.buff.FightBuffAddCardContinueChannel", package.seeall)

local var_0_0 = class("FightBuffAddCardContinueChannel")

var_0_0.RecordCount2BuffEffect = {
	nil,
	"buff/alf_kpjp_2",
	"buff/alf_kpjp_3",
	"buff/alf_kpjp_4"
}

function var_0_0.onBuffStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entity = arg_1_1
	arg_1_0.buffUid = arg_1_2.uid

	FightController.instance:registerCallback(FightEvent.ALF_AddRecordCardUI, arg_1_0.onUpdateRecordCard, arg_1_0)

	arg_1_0.effectRes, arg_1_0.recordCount = arg_1_0:getEffectRes(arg_1_2)
	arg_1_0.loader = MultiAbLoader.New()

	arg_1_0.loader:addPath(FightHelper.getEffectUrlWithLod(arg_1_0.effectRes))
	arg_1_0.loader:startLoad(arg_1_0.createEffect, arg_1_0)
end

function var_0_0.getEffectRes(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getCO()
	local var_2_1 = FightStrUtil.instance:getSplitString2Cache(var_2_0.features, true)
	local var_2_2 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		if iter_2_1[1] == 923 then
			var_2_2 = iter_2_1[3]

			break
		end
	end

	local var_2_3 = var_0_0.RecordCount2BuffEffect[var_2_2]

	if not var_2_3 then
		logError("阿莱夫 没有找到对应数量的特效 ： " .. tostring(var_2_2))

		return var_0_0.RecordCount2BuffEffect[2], 2
	end

	return var_2_3, var_2_2
end

function var_0_0.createEffect(arg_3_0, arg_3_1)
	arg_3_0.effectWrap = arg_3_0.entity.effect:addHangEffect(arg_3_0.effectRes, ModuleEnum.SpineHangPointRoot)

	arg_3_0.effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_3_0.entity.id, arg_3_0.effectWrap)
	arg_3_0.entity.buff:addLoopBuff(arg_3_0.effectWrap)
	arg_3_0:refreshEffect()
end

function var_0_0.onBuffEnd(arg_4_0)
	arg_4_0:clear()
end

function var_0_0.clear(arg_5_0)
	arg_5_0:resetMat()
	arg_5_0:clearTextureLoader()

	if arg_5_0.loader then
		arg_5_0.loader:dispose()

		arg_5_0.loader = nil
	end

	if arg_5_0.effectWrap then
		arg_5_0.entity.buff:removeLoopBuff(arg_5_0.effectWrap)
		arg_5_0.entity.effect:removeEffect(arg_5_0.effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_5_0.entity.id, arg_5_0.effectWrap)

		arg_5_0.effectWrap = nil
	end

	FightController.instance:unregisterCallback(FightEvent.ALF_AddRecordCardUI, arg_5_0.onUpdateRecordCard, arg_5_0)
end

function var_0_0.dispose(arg_6_0)
	arg_6_0:clear()
end

function var_0_0.onUpdateRecordCard(arg_7_0)
	arg_7_0:refreshEffect()
end

var_0_0.PreFix = "root/l_boli"
var_0_0.RecordCountNameDict = {
	[2] = {
		"l_boli01_di",
		"l_boli01_di03"
	},
	[3] = {
		"l_boli01_di",
		"l_boli01_di02",
		"l_boli01_di03"
	},
	[4] = {
		"l_boli01_di",
		"l_boli01_di02",
		"l_boli01_di03",
		"l_boli01_di04"
	}
}

function var_0_0.clearTextureLoader(arg_8_0)
	if arg_8_0.textureLoader then
		arg_8_0.textureLoader:dispose()

		arg_8_0.textureLoader = nil
	end
end

function var_0_0.getAlfCacheSkillList(arg_9_0)
	local var_9_0 = arg_9_0.entity.heroCustomComp and arg_9_0.entity.heroCustomComp:getCustomComp()

	if var_9_0 then
		return var_9_0:getCacheSkillList()
	end
end

function var_0_0.refreshEffect(arg_10_0)
	if not arg_10_0.effectWrap then
		return
	end

	arg_10_0:clearTextureLoader()

	arg_10_0.skillResList = arg_10_0.skillResList or {}

	tabletool.clear(arg_10_0.skillResList)

	local var_10_0 = arg_10_0:getAlfCacheSkillList()

	if not var_10_0 then
		arg_10_0:resetMat()

		return
	end

	if #var_10_0 < 2 then
		arg_10_0:resetMat()

		return
	end

	arg_10_0.textureLoader = MultiAbLoader.New()

	for iter_10_0 = 2, #var_10_0 do
		local var_10_1 = lua_skill.configDict[var_10_0[iter_10_0]]
		local var_10_2 = var_10_1 and var_10_1.icon

		if not string.nilorempty(var_10_2) then
			local var_10_3 = ResUrl.getSkillIcon(var_10_2)

			arg_10_0.textureLoader:addPath(var_10_3)
			table.insert(arg_10_0.skillResList, var_10_3)
		else
			table.insert(arg_10_0.skillResList, nil)
		end
	end

	arg_10_0.textureLoader:startLoad(arg_10_0._refreshEffect, arg_10_0)
end

function var_0_0._refreshEffect(arg_11_0)
	local var_11_0 = var_0_0.RecordCountNameDict[arg_11_0.recordCount]
	local var_11_1 = arg_11_0.effectWrap.effectGO

	for iter_11_0 = 1, arg_11_0.recordCount do
		local var_11_2 = var_11_0[iter_11_0]
		local var_11_3 = string.format("%s/%s/mask", var_0_0.PreFix, var_11_2)
		local var_11_4 = gohelper.findChild(var_11_1, var_11_3)
		local var_11_5 = arg_11_0.skillResList[iter_11_0]
		local var_11_6 = var_11_5 and arg_11_0.textureLoader:getAssetItem(var_11_5)
		local var_11_7 = var_11_6 and var_11_6:GetResource()

		if var_11_4 then
			local var_11_8 = var_11_4:GetComponent(gohelper.Type_Render)
			local var_11_9 = var_11_8 and var_11_8.material

			if var_11_9 then
				var_11_9:SetTexture("_MainTex", var_11_7)
			end
		end
	end
end

function var_0_0.resetMat(arg_12_0)
	if not arg_12_0.effectWrap then
		return
	end

	local var_12_0 = var_0_0.RecordCountNameDict[arg_12_0.recordCount]
	local var_12_1 = arg_12_0.effectWrap.effectGO

	for iter_12_0 = 1, arg_12_0.recordCount do
		local var_12_2 = var_12_0[iter_12_0]
		local var_12_3 = string.format("%s/%s/mask", var_0_0.PreFix, var_12_2)
		local var_12_4 = gohelper.findChild(var_12_1, var_12_3)

		if var_12_4 then
			local var_12_5 = var_12_4:GetComponent(gohelper.Type_Render)
			local var_12_6 = var_12_5 and var_12_5.material

			if var_12_6 then
				var_12_6:SetTexture("_MainTex", nil)
			end
		end
	end
end

return var_0_0
