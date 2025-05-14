module("modules.logic.herogroup.view.HeroGroupRecommendView", package.seeall)

local var_0_0 = class("HeroGroupRecommendView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollgroup = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_group")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#siamge_bg")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getHeroGroupBg("full/tuijianbeijingdi_036"))
end

function var_0_0._refreshUI(arg_5_0)
	local var_5_0 = arg_5_0.viewParam

	HeroGroupRecommendCharacterListModel.instance:setCharacterList(var_5_0.racommends)
end

function var_0_0._onClickRecommendCharacter(arg_6_0)
	arg_6_0._scrollgroup.verticalNormalizedPosition = 1
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_refreshUI()
	arg_7_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickRecommendCharacter, arg_7_0._onClickRecommendCharacter, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
end

return var_0_0
