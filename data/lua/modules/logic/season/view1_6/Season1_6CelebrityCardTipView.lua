module("modules.logic.season.view1_6.Season1_6CelebrityCardTipView", package.seeall)

local var_0_0 = class("Season1_6CelebrityCardTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	local var_1_0 = GMController.instance:getGMNode("seasoncelebritycardtipview", arg_1_0.viewGO)

	if var_1_0 then
		arg_1_0._gogm = gohelper.findChild(var_1_0, "#go_gm")
		arg_1_0._txtmattip = gohelper.findChildText(var_1_0, "#go_gm/bg/#txt_mattip")
		arg_1_0._btnone = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_one")
		arg_1_0._btnten = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_ten")
		arg_1_0._btnhundred = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_hundred")
		arg_1_0._btnthousand = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_thousand")
		arg_1_0._btntenthousand = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_tenthousand")
		arg_1_0._btntenmillion = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_tenmillion")
		arg_1_0._btninput = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_input")
	end

	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._txtpropname = gohelper.findChildText(arg_1_0.viewGO, "#txt_propname")
	arg_1_0._txtpropnameen = gohelper.findChildText(arg_1_0.viewGO, "#txt_propname/#txt_propnameen")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/viewport/content/#go_effect")
	arg_1_0._goeffectitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/viewport/content/#go_effect/#go_effectitem")
	arg_1_0._goeffectdesc = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/viewport/content/#go_effectdesc")
	arg_1_0._goeffectdescitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/viewport/content/#go_effectdesc/#go_effectdescitem")
	arg_1_0._txthadnumber = gohelper.findChildText(arg_1_0.viewGO, "#go_quantity/#txt_hadnumber")
	arg_1_0._goquantity = gohelper.findChild(arg_1_0.viewGO, "#go_quantity")
	arg_1_0._gocard = gohelper.findChild(arg_1_0.viewGO, "#go_card")
	arg_1_0._gocarditem = gohelper.findChild(arg_1_0.viewGO, "#go_ctrl/#go_targetcardpos/#go_carditem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)

	if arg_2_0._gogm then
		arg_2_0._btnone:AddClickListener(arg_2_0.onClickGMAdd, arg_2_0, 1)
		arg_2_0._btnten:AddClickListener(arg_2_0.onClickGMAdd, arg_2_0, 10)
		arg_2_0._btnhundred:AddClickListener(arg_2_0.onClickGMAdd, arg_2_0, 100)
		arg_2_0._btnthousand:AddClickListener(arg_2_0.onClickGMAdd, arg_2_0, 1000)
		arg_2_0._btntenthousand:AddClickListener(arg_2_0.onClickGMAdd, arg_2_0, 10000)
		arg_2_0._btntenmillion:AddClickListener(arg_2_0.onClickGMAdd, arg_2_0, 10000000)
		arg_2_0._btninput:AddClickListener(arg_2_0._btninputOnClick, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()

	if arg_3_0._gogm then
		arg_3_0._btnone:RemoveClickListener()
		arg_3_0._btnten:RemoveClickListener()
		arg_3_0._btnhundred:RemoveClickListener()
		arg_3_0._btnthousand:RemoveClickListener()
		arg_3_0._btntenthousand:RemoveClickListener()
		arg_3_0._btntenmillion:RemoveClickListener()
		arg_3_0._btninput:RemoveClickListener()
	end
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickGMAdd(arg_5_0, arg_5_1)
	GameFacade.showToast(ToastEnum.GMTool5, arg_5_0.viewParam.id)
	GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", arg_5_0.viewParam.type, arg_5_0.viewParam.id, 10))
end

function var_0_0._btninputOnClick(arg_6_0)
	local var_6_0 = CommonInputMO.New()

	var_6_0.title = "请输入增加道具数量！"
	var_6_0.defaultInput = "Enter Item Num"

	function var_6_0.sureCallback(arg_7_0)
		GameFacade.closeInputBox()

		local var_7_0 = tonumber(arg_7_0)

		if var_7_0 and var_7_0 > 0 then
			GameFacade.showToast(ToastEnum.GMTool5, arg_6_0.viewParam.id)
			GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", arg_6_0.viewParam.type, arg_6_0.viewParam.id, var_7_0))
		end
	end

	GameFacade.openInputBox(var_6_0)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_8_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_8_0._goSkillTitle = gohelper.findChild(arg_8_0.viewGO, "#scroll_desc/viewport/content/#go_effectdesc/title")
	arg_8_0._propItems = {}
	arg_8_0._skillItems = {}

	if arg_8_0._gogm then
		gohelper.setActive(arg_8_0._gogm, GMController.instance:isOpenGM())
	end
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagebg1:UnLoadImage()
	arg_9_0._simagebg2:UnLoadImage()

	if arg_9_0._icon then
		arg_9_0._icon:disposeUI()

		arg_9_0._icon = nil
	end
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._itemId = arg_10_0.viewParam.id
	arg_10_0._itemCfg = ItemModel.instance:getItemConfigAndIcon(arg_10_0.viewParam.type, arg_10_0._itemId)
	arg_10_0._activityId = arg_10_0.viewParam.actId or Activity104Model.instance:getCurSeasonId()

	if not arg_10_0._itemCfg then
		logError("can't find card cfg : " .. tostring(arg_10_0._itemId))

		return
	end

	arg_10_0:refreshUI()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0._txtpropname.text = arg_12_0._itemCfg.name

	if arg_12_0._txtmattip then
		arg_12_0._txtmattip.text = tostring(arg_12_0.viewParam.type) .. "#" .. tostring(arg_12_0.viewParam.id)
	end

	arg_12_0:checkCreateIcon()
	arg_12_0._icon:updateData(arg_12_0._itemId)
	arg_12_0:refreshQuantity()

	local var_12_0 = arg_12_0:refreshProps()
	local var_12_1 = arg_12_0:refreshSkills()

	if not var_12_0 or not var_12_1 then
		gohelper.setActive(arg_12_0._goSkillTitle, false)
	end
end

function var_0_0.refreshQuantity(arg_13_0)
	if arg_13_0.viewParam.needQuantity then
		gohelper.setActive(arg_13_0._goquantity, true)

		local var_13_0

		if arg_13_0.viewParam.fakeQuantity then
			var_13_0 = tostring(arg_13_0.viewParam.fakeQuantity)
		elseif arg_13_0._activityId then
			var_13_0 = tostring(GameUtil.numberDisplay(SeasonEquipMetaUtils.getEquipCount(arg_13_0._activityId, arg_13_0._itemId)))
		else
			var_13_0 = tostring(SeasonEquipMetaUtils.getCurSeasonEquipCount(arg_13_0._itemId))
		end

		arg_13_0._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", var_13_0)
	else
		gohelper.setActive(arg_13_0._goquantity, false)
	end
end

function var_0_0.refreshProps(arg_14_0)
	local var_14_0 = false
	local var_14_1 = SeasonEquipMetaUtils.getEquipPropsStrList(arg_14_0._itemCfg.attrId, true)
	local var_14_2 = SeasonEquipMetaUtils.getCareerColorBrightBg(arg_14_0._itemId)
	local var_14_3 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_4 = arg_14_0:getOrCreatePropText(iter_14_0)

		gohelper.setActive(var_14_4.go, true)

		var_14_4.txtDesc.text = iter_14_1

		SLFramework.UGUI.GuiHelper.SetColor(var_14_4.txtDesc, var_14_2)
		SLFramework.UGUI.GuiHelper.SetColor(var_14_4.imagePoint, var_14_2)

		var_14_3[var_14_4] = true
		var_14_0 = true
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0._propItems) do
		if not var_14_3[iter_14_3] then
			gohelper.setActive(iter_14_3.go, false)
		end
	end

	gohelper.setActive(arg_14_0._goeffect, var_14_0)

	return var_14_0
end

function var_0_0.refreshSkills(arg_15_0)
	local var_15_0 = SeasonEquipMetaUtils.getSkillEffectStrList(arg_15_0._itemCfg)
	local var_15_1 = SeasonEquipMetaUtils.getCareerColorBrightBg(arg_15_0._itemId)
	local var_15_2 = false
	local var_15_3 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_4 = arg_15_0:getOrCreateSkillText(iter_15_0)

		gohelper.setActive(var_15_4.go, true)

		var_15_4.txtDesc.text = iter_15_1

		SLFramework.UGUI.GuiHelper.SetColor(var_15_4.txtDesc, var_15_1)
		SLFramework.UGUI.GuiHelper.SetColor(var_15_4.imagePoint, var_15_1)

		var_15_3[var_15_4] = true
		var_15_2 = true
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_0._skillItems) do
		if not var_15_3[iter_15_3] then
			gohelper.setActive(iter_15_3.go, false)
		end
	end

	return var_15_2
end

function var_0_0.checkCreateIcon(arg_16_0)
	if not arg_16_0._icon then
		local var_16_0 = arg_16_0.viewContainer:getSetting().otherRes[1]
		local var_16_1 = arg_16_0:getResInst(var_16_0, arg_16_0._gocard, "icon")

		arg_16_0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_1, Season1_6CelebrityCardEquip)
	end
end

function var_0_0.getOrCreatePropText(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._propItems[arg_17_1]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.go = gohelper.cloneInPlace(arg_17_0._goeffectitem, "propname_" .. tostring(arg_17_1))
		var_17_0.txtDesc = gohelper.findChildText(var_17_0.go, "txt_desc")
		var_17_0.imagePoint = gohelper.findChildImage(var_17_0.go, "point")
		arg_17_0._propItems[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0.getOrCreateSkillText(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._skillItems[arg_18_1]

	if not var_18_0 then
		var_18_0 = arg_18_0:getUserDataTb_()
		var_18_0.go = gohelper.cloneInPlace(arg_18_0._goeffectdescitem, "skill_" .. tostring(arg_18_1))
		var_18_0.txtDesc = gohelper.findChildText(var_18_0.go, "txt_desc")
		var_18_0.imagePoint = gohelper.findChildImage(var_18_0.go, "point")
		arg_18_0._skillItems[arg_18_1] = var_18_0
	end

	return var_18_0
end

function var_0_0.onClickModalMask(arg_19_0)
	arg_19_0:closeThis()
end

return var_0_0
