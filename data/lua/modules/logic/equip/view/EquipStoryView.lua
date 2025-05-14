module("modules.logic.equip.view.EquipStoryView", package.seeall)

local var_0_0 = class("EquipStoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtnameEn = gohelper.findChildText(arg_1_0.viewGO, "#txt_name/#txt_nameen")
	arg_1_0._goskillpos = gohelper.findChild(arg_1_0.viewGO, "#go_skillpos")

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
	arg_4_0.txt_skilldesc = SLFramework.GameObjectHelper.FindChildComponent(arg_4_0.viewGO, "desc/txt_skilldesc", typeof(TMPro.TextMeshProUGUI))
	arg_4_0._viewAnim = gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._equipMO = arg_5_0.viewContainer.viewParam.equipMO
	arg_5_0._equipId = arg_5_0._equipMO and arg_5_0._equipMO.config.id or arg_5_0.viewContainer.viewParam.equipId
	arg_5_0._config = arg_5_0._equipMO and arg_5_0._equipMO.config or EquipConfig.instance:getEquipCo(arg_5_0._equipId)
	arg_5_0._txtname.text = arg_5_0._config.name
	arg_5_0._txtnameEn.text = arg_5_0._config.name_en
	arg_5_0.txt_skilldesc.text = arg_5_0._config.desc

	if arg_5_0.viewContainer:getIsOpenLeftBackpack() then
		arg_5_0.viewContainer.equipView:showTitleAndCenter()
	end

	arg_5_0._viewAnim:Play(UIAnimationName.Open)
end

function var_0_0.onOpenFinish(arg_6_0)
	return
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:playCloseAnimation()
end

function var_0_0.playCloseAnimation(arg_8_0)
	arg_8_0._viewAnim:Play(UIAnimationName.Close)
end

return var_0_0
