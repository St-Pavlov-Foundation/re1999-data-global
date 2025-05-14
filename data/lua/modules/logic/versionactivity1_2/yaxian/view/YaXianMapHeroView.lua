module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapHeroView", package.seeall)

local var_0_0 = class("YaXianMapHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickDetail(arg_4_0)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = arg_4_0.heroId
	})
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.simageHeroIcon = gohelper.findChildSingleImage(arg_5_0.viewGO, "window/role/icon")
	arg_5_0.detailClick = gohelper.findChildClick(arg_5_0.viewGO, "window/role/icon/detail")
	arg_5_0.txtName = gohelper.findChildText(arg_5_0.viewGO, "window/role/name")

	arg_5_0.detailClick:AddClickListener(arg_5_0.onClickDetail, arg_5_0)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.maxTrialTemplateId = YaXianModel.instance:getMaxTrialTemplateId()
	arg_7_0.heroId, arg_7_0.skinId = YaXianModel.instance:getHeroIdAndSkinId()

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = HeroConfig.instance:getHeroCO(arg_8_0.heroId)

	arg_8_0.txtName.text = var_8_0.name

	arg_8_0:refreshHeroIcon()
end

function var_0_0.refreshHeroIcon(arg_9_0)
	local var_9_0 = SkinConfig.instance:getSkinCo(arg_9_0.skinId)

	arg_9_0.simageHeroIcon:LoadImage(ResUrl.getHeadIconMiddle(var_9_0.retangleIcon))
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0.simageHeroIcon:UnLoadImage()
	arg_11_0.detailClick:RemoveClickListener()
end

return var_0_0
