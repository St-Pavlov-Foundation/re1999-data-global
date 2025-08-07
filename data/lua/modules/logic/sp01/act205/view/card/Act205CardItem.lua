module("modules.logic.sp01.act205.view.card.Act205CardItem", package.seeall)

local var_0_0 = class("Act205CardItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goWeapon = gohelper.findChild(arg_1_0.go, "#go_Weapon")
	arg_1_0._simageweapon = gohelper.findChildSingleImage(arg_1_0.go, "#go_Weapon/image_WeaponPic")
	arg_1_0._txtWeaponName = gohelper.findChildText(arg_1_0.go, "#go_Weapon/#txt_WeaponName")
	arg_1_0._goRole = gohelper.findChild(arg_1_0.go, "#go_Role")
	arg_1_0._simagerole = gohelper.findChildSingleImage(arg_1_0.go, "#go_Role/image_RolePic")
	arg_1_0._txtRoleName = gohelper.findChildText(arg_1_0.go, "#go_Role/#txt_RoleName")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.go, "Scroll View/Viewport/#txt_Descr")
	arg_1_0._btnclick = gohelper.findChildClickWithAudio(arg_1_0.go, "Scroll View/#btn_click")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.go, "#go_Selected")
	arg_1_0._animator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClick, arg_2_0)
	arg_2_0:addEventCb(Act205CardController.instance, Act205Event.PlayerSelectCard, arg_2_0._onSelectCard, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(Act205CardController.instance, Act205Event.PlayerSelectCard, arg_3_0._onSelectCard, arg_3_0)
end

function var_0_0._onClick(arg_4_0)
	if not arg_4_0._canClick then
		return
	end

	Act205CardController.instance:playerClickCard(arg_4_0._cardId)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_common_click)
end

function var_0_0._onSelectCard(arg_5_0, arg_5_1)
	if not arg_5_0._cardId or not arg_5_0._canClick then
		return
	end

	arg_5_0:refreshSelected(arg_5_1 == arg_5_0._cardId)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:setCanClick()
end

function var_0_0.setData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._cardId = arg_7_1

	arg_7_0:_setCard()
	arg_7_0:setCanClick(arg_7_2)
end

function var_0_0._setCard(arg_8_0)
	local var_8_0 = Act205Config.instance:getCardType(arg_8_0._cardId) == Act205Enum.CardType.Weapon
	local var_8_1 = Act205Config.instance:getCardImg(arg_8_0._cardId)
	local var_8_2 = ResUrl.getV2a9ActSingleBg("card_item_pic/" .. var_8_1)

	if var_8_0 then
		arg_8_0._simageweapon:LoadImage(var_8_2)
	else
		arg_8_0._simagerole:LoadImage(var_8_2)
	end

	gohelper.setActive(arg_8_0._goWeapon, var_8_0)
	gohelper.setActive(arg_8_0._goRole, not var_8_0)

	local var_8_3 = Act205Config.instance:getCardName(arg_8_0._cardId)

	arg_8_0._txtWeaponName.text = var_8_3
	arg_8_0._txtRoleName.text = var_8_3

	local var_8_4 = Act205Config.instance:getCardDesc(arg_8_0._cardId)

	arg_8_0._txtDescr.text = var_8_4
end

function var_0_0.setCanClick(arg_9_0, arg_9_1)
	arg_9_0._canClick = arg_9_1

	arg_9_0:refreshSelected()
end

function var_0_0.refreshSelected(arg_10_0, arg_10_1)
	local var_10_0 = false

	if arg_10_0._canClick then
		local var_10_1 = Act205CardModel.instance:isCardSelected(arg_10_0._cardId)

		arg_10_0:playAnim(var_10_1 and "select" or "unselect", arg_10_1)
	end
end

function var_0_0.playAnim(arg_11_0, arg_11_1, arg_11_2)
	if string.nilorempty(arg_11_1) or not arg_11_0._animator then
		return
	end

	arg_11_0._animator:Play(arg_11_1, 0, arg_11_2 and 0 or 1)
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0._simageweapon:UnLoadImage()
	arg_12_0._simagerole:UnLoadImage()
end

return var_0_0
