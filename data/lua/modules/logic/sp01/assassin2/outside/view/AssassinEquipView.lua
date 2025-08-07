module("modules.logic.sp01.assassin2.outside.view.AssassinEquipView", package.seeall)

local var_0_0 = class("AssassinEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golayout = gohelper.findChild(arg_1_0.viewGO, "root/#go_layout")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_layout/#go_item")
	arg_1_0._btnconfirm = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/#btn_confirm", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()

	if arg_3_0._careerEquipItemList then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._careerEquipItemList) do
			iter_3_1.btnunlockClick:RemoveClickListener()
			iter_3_1.btnlockedClick:RemoveClickListener()
		end
	end
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	if not arg_4_0._curSelectedIndex then
		return
	end

	local var_4_0 = arg_4_0._careerEquipItemList[arg_4_0._curSelectedIndex]

	AssassinController.instance:changeCareerEquip(arg_4_0.assassinHeroId, var_4_0 and var_4_0.id)
	arg_4_0:closeThis()
end

function var_0_0._btnItemOnClick(arg_5_0, arg_5_1)
	if arg_5_0._curSelectedIndex == arg_5_1 then
		return
	end

	local var_5_0 = arg_5_0._careerEquipItemList[arg_5_1]

	if not AssassinHeroModel.instance:isUnlockCareer(var_5_0 and var_5_0.id) then
		return
	end

	arg_5_0._curSelectedIndex = arg_5_1

	arg_5_0:refreshSelectedEquipItem()
end

function var_0_0._btnItemLockOnClick(arg_6_0, arg_6_1)
	return
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0.assassinHeroId = arg_8_0.viewParam.assassinHeroId
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:onUpdateParam()
	arg_9_0:setEquipItemList()

	local var_9_0 = AssassinHeroModel.instance:getAssassinCareerId(arg_9_0.assassinHeroId)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._careerEquipItemList) do
		if iter_9_1.id == var_9_0 then
			arg_9_0:_btnItemOnClick(iter_9_0)

			return
		end
	end
end

function var_0_0.setEquipItemList(arg_10_0)
	arg_10_0._careerEquipItemList = {}

	local var_10_0 = AssassinConfig.instance:getAssassinHeroCareerList(arg_10_0.assassinHeroId)

	gohelper.CreateObjList(arg_10_0, arg_10_0._onCreateEquipItem, var_10_0, arg_10_0._golayout, arg_10_0._goitem)
end

function var_0_0._onCreateEquipItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.go = arg_11_1
	var_11_0.id = arg_11_2
	var_11_0.unlockCanvasGroup = gohelper.findChild(var_11_0.go, "#go_unlock"):GetComponent(typeof(UnityEngine.CanvasGroup))
	var_11_0.goselected = gohelper.findChild(var_11_0.go, "#go_unlock/#go_selected")
	var_11_0.txtcareer = gohelper.findChildText(var_11_0.go, "#go_unlock/career/#txt_career")
	var_11_0.txtname = gohelper.findChildText(var_11_0.go, "#go_unlock/#txt_name")
	var_11_0.simageicon = gohelper.findChildSingleImage(var_11_0.go, "#go_unlock/#simage_icon")
	var_11_0.goitemLayout = gohelper.findChild(var_11_0.go, "#go_unlock/#go_itemLayout")
	var_11_0.goitemGrid = gohelper.findChild(var_11_0.go, "#go_unlock/#go_itemLayout/#go_itemGrid")
	var_11_0.goattrLayout = gohelper.findChild(var_11_0.go, "#go_unlock/#go_attrLayout")
	var_11_0.goattrItem = gohelper.findChild(var_11_0.go, "#go_unlock/#go_attrLayout/#go_attrItem")
	var_11_0.txtdesc = gohelper.findChildText(var_11_0.go, "#go_unlock/#go_assassinSkill/ScrollView/Viewport/#txt_desc")
	var_11_0.btnunlockClick = gohelper.findChildClickWithAudio(var_11_0.go, "#go_unlock/#go_assassinSkill/ScrollView/#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_skillchoose)

	var_11_0.btnunlockClick:AddClickListener(arg_11_0._btnItemOnClick, arg_11_0, arg_11_3)

	var_11_0.golocked = gohelper.findChild(var_11_0.go, "#go_locked")
	var_11_0.btnlockedClick = gohelper.findChildClickWithAudio(var_11_0.go, "#go_locked/#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_skillchoose)

	var_11_0.btnlockedClick:AddClickListener(arg_11_0._btnItemLockOnClick, arg_11_0, arg_11_3)

	var_11_0.txtcareer.text = AssassinConfig.instance:getAssassinCareerTitle(var_11_0.id)
	var_11_0.txtname.text = AssassinConfig.instance:getAssassinCareerEquipName(var_11_0.id)

	local var_11_1 = AssassinConfig.instance:getAssassinCareerEquipPic(var_11_0.id)
	local var_11_2 = ResUrl.getSp01AssassinSingleBg("weapon/" .. var_11_1)

	var_11_0.simageicon:LoadImage(var_11_2)

	local var_11_3 = AssassinConfig.instance:getAssassinSkillIdByHeroCareer(arg_11_0.assassinHeroId, var_11_0.id)

	var_11_0.txtdesc.text = AssassinConfig.instance:getAssassinCareerSkillDesc(var_11_3)

	local var_11_4 = AssassinConfig.instance:getAssassinCareerCapacity(var_11_0.id)

	gohelper.CreateNumObjList(var_11_0.goitemLayout, var_11_0.goitemGrid, var_11_4)

	local var_11_5 = AssassinConfig.instance:getAssassinCareerAttrList(var_11_0.id)

	gohelper.CreateObjList(arg_11_0, arg_11_0._onCreateCareerEquipAttrItem, var_11_5, var_11_0.goattrLayout, var_11_0.goattrItem)

	local var_11_6 = AssassinHeroModel.instance:isUnlockCareer(var_11_0.id)

	var_11_0.unlockCanvasGroup.alpha = var_11_6 and 1 or 0.25

	gohelper.setActive(var_11_0.golocked, not var_11_6)
	gohelper.setActive(var_11_0.goselected, false)

	arg_11_0._careerEquipItemList[arg_11_3] = var_11_0
end

function var_0_0._onCreateCareerEquipAttrItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildImage(arg_12_1, "icon")
	local var_12_1 = gohelper.findChildText(arg_12_1, "#txt_attrName")
	local var_12_2 = gohelper.findChildText(arg_12_1, "#txt_attrValue")
	local var_12_3 = arg_12_2[1]
	local var_12_4 = HeroConfig.instance:getHeroAttributeCO(var_12_3)

	CharacterController.instance:SetAttriIcon(var_12_0, var_12_3, GameUtil.parseColor("#675C58"))

	var_12_1.text = var_12_4.name
	var_12_2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("add_percent_value"), (arg_12_2[2] or 0) / 10)
end

function var_0_0.refreshSelectedEquipItem(arg_13_0)
	if arg_13_0._careerEquipItemList then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0._careerEquipItemList) do
			gohelper.setActive(iter_13_1.goselected, arg_13_0._curSelectedIndex == iter_13_0)
		end
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	if arg_15_0._careerEquipItemList then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._careerEquipItemList) do
			iter_15_1.simageicon:UnLoadImage()
		end
	end
end

return var_0_0
