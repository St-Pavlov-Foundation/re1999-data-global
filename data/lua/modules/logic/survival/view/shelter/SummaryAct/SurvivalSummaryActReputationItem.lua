module("modules.logic.survival.view.shelter.SummaryAct.SurvivalSummaryActReputationItem", package.seeall)

local var_0_0 = class("SurvivalSummaryActReputationItem", SurvivalSimpleListItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_icon")
	arg_1_0._txtdec1 = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_dec1")
	arg_1_0._txtdec2 = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_dec2")
end

function var_0_0.onItemShow(arg_2_0, arg_2_1)
	arg_2_0.reputationId = arg_2_1.reputationId
	arg_2_0.value = arg_2_1.value
	arg_2_0.npcs = arg_2_1.npcs
	arg_2_0.weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	arg_2_0.reputationLevel = arg_2_0.weekInfo:getBuildingMoByReputationId(arg_2_0.reputationId).survivalReputationPropMo.prop.reputationLevel
	arg_2_0.reputationCfg = SurvivalConfig.instance:getReputationCfgById(arg_2_0.reputationId, arg_2_0.reputationLevel)

	local var_2_0 = arg_2_0.reputationCfg.type
	local var_2_1 = SurvivalUnitIconHelper.instance:getRelationIcon(var_2_0)

	UISpriteSetMgr.instance:setSurvivalSprite(arg_2_0._imageicon, var_2_1)

	local var_2_2 = arg_2_0.reputationCfg.name

	arg_2_0._txtdec1.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalSummaryActReputationItem_1"), {
		var_2_2,
		#arg_2_0.npcs
	})
	arg_2_0._txtdec2.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalSummaryActReputationItem_2"), {
		var_2_2,
		arg_2_0.value
	})
end

return var_0_0
