module("modules.logic.survival.view.shelter.SurvivalMonsterEventSmallNpcItem", package.seeall)

local var_0_0 = class("SurvivalMonsterEventSmallNpcItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "#go_has")
	arg_1_0._simagehero = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_has/#simage_hero")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._isCanEnter then
		GameFacade.showToast(ToastEnum.SurvivalBossDotSelectNpc)

		return
	end

	ViewMgr.instance:openView(ViewName.SurvivalNpcStationView)
end

function var_0_0.updateItem(arg_5_0, arg_5_1)
	arg_5_0._npcId = arg_5_1

	gohelper.setActive(arg_5_0._goempty, arg_5_1 == nil)
	gohelper.setActive(arg_5_0._gohas, arg_5_1 ~= nil)

	if arg_5_0._npcId then
		local var_5_0 = SurvivalConfig.instance:getNpcConfig(arg_5_0._npcId)

		if var_5_0 then
			local var_5_1 = ResUrl.getSurvivalNpcIcon(var_5_0.smallIcon)

			arg_5_0._simagehero:LoadImage(var_5_1)
		end
	end

	gohelper.setActive(arg_5_0._goempty, arg_5_0._showEmpty)
end

function var_0_0.setIsCanEnterSelect(arg_6_0, arg_6_1)
	arg_6_0._isCanEnter = arg_6_1
end

function var_0_0.setNeedShowEmpty(arg_7_0, arg_7_1)
	arg_7_0._showEmpty = arg_7_1
end

return var_0_0
