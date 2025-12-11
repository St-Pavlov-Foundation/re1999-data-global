module("modules.logic.character.view.recommed.CharacterRecommedGroupView", package.seeall)

local var_0_0 = class("CharacterRecommedGroupView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gogroup = gohelper.findChild(arg_1_0.viewGO, "content/group")
	arg_1_0._imagegroupicon = gohelper.findChildImage(arg_1_0.viewGO, "content/group/title/icon")
	arg_1_0._scrollgroup = gohelper.findChildScrollRect(arg_1_0.viewGO, "content/group/#scroll_group")
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "content/equip")
	arg_1_0._imageequipicon = gohelper.findChildImage(arg_1_0.viewGO, "content/equip/title/icon")
	arg_1_0._scrollequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "content/equip/#scroll_equip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, arg_2_0._refreshHero, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, arg_3_0._refreshHero, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_refreshHero(arg_6_0.viewParam.heroId)
	arg_6_0:playViewAnim(CharacterRecommedEnum.AnimName.Open, 0, 0)

	if arg_6_0._groupItems then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._groupItems) do
			iter_6_1:playViewAnim(CharacterRecommedEnum.AnimName.Open, 0, 0)
		end
	end
end

function var_0_0._refreshHero(arg_7_0, arg_7_1)
	if arg_7_0.heroId and arg_7_1 == arg_7_0.heroId then
		return
	end

	arg_7_0.heroId = arg_7_1
	arg_7_0._heroRecommendMO = CharacterRecommedModel.instance:getHeroRecommendMo(arg_7_1)

	local var_7_0 = arg_7_0._heroRecommendMO:isShowTeam()
	local var_7_1 = arg_7_0._heroRecommendMO:isShowEquip()

	if var_7_0 then
		arg_7_0:_refreshGroup()
	end

	if var_7_1 then
		arg_7_0:_refreshEquip()
	end

	gohelper.setActive(arg_7_0._gogroup, var_7_0)
	gohelper.setActive(arg_7_0._goequip, var_7_1)
end

function var_0_0._refreshGroup(arg_8_0)
	if not arg_8_0._heroRecommendMO then
		return
	end

	local var_8_0 = arg_8_0._heroRecommendMO.teamRec

	if var_8_0 then
		if not arg_8_0._goGroupItem then
			arg_8_0._goGroupItem = arg_8_0.viewContainer:getGroupItemRes()
		end

		arg_8_0._groupItems = {}

		gohelper.CreateObjList(arg_8_0, arg_8_0._groupItemCB, var_8_0, arg_8_0._scrollgroup.content.gameObject, arg_8_0._goGroupItem, CharacterRecommedGroupItem)
	end
end

function var_0_0._groupItemCB(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_1:onUpdateMO(arg_9_2, arg_9_0.viewContainer, arg_9_0._heroRecommendMO)
	arg_9_1:setIndex(arg_9_3)

	local var_9_0 = arg_9_0.viewParam.fromView and arg_9_0.viewParam.fromView == ViewName.CharacterView

	arg_9_1:showUseBtn(var_9_0)

	arg_9_0._groupItems[arg_9_3] = arg_9_1
end

function var_0_0._refreshEquip(arg_10_0)
	if not arg_10_0._heroRecommendMO then
		return
	end

	if not arg_10_0._goequipicon then
		arg_10_0._goequipicon = arg_10_0.viewContainer:getEquipIconRes()
	end

	local var_10_0 = arg_10_0._heroRecommendMO.equipRec

	if var_10_0 then
		gohelper.CreateObjList(arg_10_0, arg_10_0._equipItemCB, var_10_0, arg_10_0._scrollequip.content.gameObject, arg_10_0._goequipicon, CharacterRecommedEquipIcon)
	end
end

function var_0_0._equipItemCB(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_1:onUpdateMO(arg_11_2)
	arg_11_1:setClickCallback(function()
		EquipController.instance:openEquipView({
			equipId = arg_11_2
		})
	end, arg_11_0)
end

function var_0_0.playViewAnim(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0._viewAnim then
		arg_13_0._viewAnim = arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if arg_13_0._viewAnim then
		arg_13_0._viewAnim:Play(arg_13_1, arg_13_2, arg_13_3)
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
