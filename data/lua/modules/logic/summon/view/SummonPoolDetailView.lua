module("modules.logic.summon.view.SummonPoolDetailView", package.seeall)

local var_0_0 = class("SummonPoolDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_top")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bottom")
	arg_1_0._txtinfotitle = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_infotitle")
	arg_1_0._txtinfotitleEn = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_infotitle/#txt_infotitleEn")
	arg_1_0._btnclose = gohelper.findChildButton(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gospecialtitle = gohelper.findChild(arg_1_0.viewGO, "info/#go_specialtitle")
	arg_1_0._txtspecialtitlecn = gohelper.findChildText(arg_1_0.viewGO, "info/#go_specialtitle/#txt_specialtitlecn")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_line")
	arg_1_0._txttitlecn = gohelper.findChildText(arg_1_0.viewGO, "#txt_titlecn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0:addEventCb(SummonController.instance, SummonEvent.onSummonPoolDetailCategoryClick, arg_2_0._refreshTitle, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:addEventCb(SummonController.instance, SummonEvent.onSummonPoolDetailCategoryClick, arg_3_0._refreshTitle, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_4_0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	arg_4_0._txttitleen = gohelper.findChildText(arg_4_0._txttitlecn.gameObject, "titleen")
	arg_4_0._gotitleline = gohelper.findChild(arg_4_0._txttitlecn.gameObject, "Line")
end

function var_0_0._refreshTitle(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._txtinfotitle.gameObject, arg_5_1 ~= 1)
	gohelper.setActive(arg_5_0._gospecialtitle, arg_5_1 == 1)

	local var_5_0 = SummonConfig.instance:getSummonPool(arg_5_0._poolId)
	local var_5_1
	local var_5_2
	local var_5_3 = true

	if not arg_5_0._summonSimulationActId then
		var_5_1 = var_5_0.nameCn
		var_5_2 = var_5_0.nameEn
	else
		local var_5_4 = SummonSimulationPickConfig.instance:getSummonConfigById(arg_5_0._summonSimulationActId)

		var_5_1 = ItemConfig.instance:getItemCo(var_5_4.itemId).name
		var_5_2 = ""
		var_5_3 = false
	end

	if arg_5_1 ~= 1 then
		arg_5_0._txtinfotitle.text = SummonPoolDetailCategoryListModel.getName(arg_5_1)
		arg_5_0._txtinfotitleEn.text = SummonPoolDetailCategoryListModel.getNameEn(arg_5_1)
	else
		local var_5_5, var_5_6 = arg_5_0:_splitTitle2Part(var_5_1, 1)

		arg_5_0._txtspecialtitlecn.text = string.format("<size=60>%s</size>%s", var_5_5, var_5_6)
	end

	local var_5_7 = luaLang("ruledetail")

	arg_5_0._txttitlecn.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("summon_pool_exchange"), var_5_1, var_5_7)

	if var_5_3 then
		arg_5_0._txttitleen.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("summon_pool_exchange"), var_5_2, "Rules")
	end

	arg_5_0:_refreshline(arg_5_1)
end

function var_0_0._splitTitle2Part(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or 1

	if string.nilorempty(arg_6_1) or arg_6_2 >= GameUtil.utf8len(arg_6_1) then
		return arg_6_1, ""
	end

	local var_6_0 = GameUtil.utf8sub(arg_6_1, 1, arg_6_2)
	local var_6_1 = ""

	if GameUtil.utf8len(arg_6_1) >= arg_6_2 + 1 then
		var_6_1 = GameUtil.utf8sub(arg_6_1, arg_6_2 + 1, GameUtil.utf8len(arg_6_1) - arg_6_2)
	end

	return var_6_0, var_6_1
end

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = SummonConfig.instance:getPoolDetailConfig(arg_7_0._poolDetailId)

	SummonPoolDetailCategoryListModel.instance:initCategory()
	arg_7_0.viewContainer._views[1]:selectCell(1, true)
end

function var_0_0._refreshline(arg_8_0, arg_8_1)
	if arg_8_1 ~= 1 then
		gohelper.setActive(arg_8_0._goline, true)

		return
	end

	local var_8_0 = SummonConfig.instance:getSummonPool(arg_8_0._poolId)
	local var_8_1 = SummonMainModel.isProbUp(var_8_0)

	gohelper.setActive(arg_8_0._goline, not var_8_1)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:_initData()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_initData()
end

function var_0_0._initData(arg_11_0)
	arg_11_0._poolId = arg_11_0.viewParam.poolId
	arg_11_0._luckyBagId = arg_11_0.viewParam.luckyBagId
	arg_11_0._summonSimulationActId = arg_11_0.viewParam.summonSimulationActId

	SummonPoolDetailCategoryListModel.instance:setJumpLuckyBag(arg_11_0._luckyBagId)
	arg_11_0:_refreshUI()
	arg_11_0:_refreshTitle(1)
	SummonController.instance:statViewPoolDetail(arg_11_0._poolId)
	SummonController.instance:setPoolInfo(arg_11_0.viewParam)
end

function var_0_0._btnCloseOnClick(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_12_0:closeThis()
end

function var_0_0.onClose(arg_13_0)
	SummonController.instance:statExitPoolDetail()
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simagetop:UnLoadImage()
	arg_14_0._simagebottom:UnLoadImage()
end

function var_0_0.onClickModalMask(arg_15_0)
	arg_15_0:closeThis()
end

return var_0_0
