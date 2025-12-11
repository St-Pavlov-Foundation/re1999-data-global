module("modules.logic.herogrouppreset.view.HeroGroupPresetFightView", package.seeall)

local var_0_0 = class("HeroGroupPresetFightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnmodifyname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/#btn_changename")
	arg_1_0._btnchangeteam = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/#btn_changeteam")
	arg_1_0._txtherogroupname = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/Label")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if arg_2_0._btnchangeteam then
		arg_2_0._btnchangeteam:AddClickListener(arg_2_0._changeTeam, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._btnchangeteam then
		arg_3_0._btnchangeteam:RemoveClickListener()
	end
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goherogroupcontain = gohelper.findChild(arg_4_0.viewGO, "herogroupcontain")

	arg_4_0:addEventCb(HeroGroupPresetController.instance, HeroGroupPresetEvent.UseHeroGroup, arg_4_0._onUseHeroGroup, arg_4_0)
	arg_4_0:addEventCb(HeroGroupPresetController.instance, HeroGroupPresetEvent.UpdateGroupName, arg_4_0._onUpdateGroupName, arg_4_0)
	HeroGroupPresetController.instance:initCopyHeroGroupList()
end

function var_0_0._onUpdateGroupName(arg_5_0)
	arg_5_0:_updateHeroGroupName()
end

function var_0_0.onClose(arg_6_0)
	HeroGroupPresetController.instance:revertCurHeroGroup()
	HeroGroupPresetController.instance:clearCopyList()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_initChangeTeam()
end

function var_0_0._onUseHeroGroup(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.subId

	if HeroGroupModel.instance:setHeroGroupSelectIndex(var_8_0) then
		HeroGroupModel.instance:_setSingleGroup()

		local var_8_1 = arg_8_0.viewContainer:getHeroGroupFightView()

		var_8_1:_checkEquipClothSkill()
		GameFacade.showToast(var_8_1._changeToastId or ToastEnum.SeasonGroupChanged)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(arg_8_0._goherogroupcontain, false)
		gohelper.setActive(arg_8_0._goherogroupcontain, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
	end

	arg_8_0:_updateHeroGroupName()
end

function var_0_0._initChangeTeam(arg_9_0)
	if not HeroGroupModel.instance:getPresetHeroGroupType() then
		return
	end

	local var_9_0 = gohelper.findChild(arg_9_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/arrow")

	gohelper.setActive(var_9_0, false)
	gohelper.setActive(arg_9_0._btnmodifyname, false)
	gohelper.setActive(arg_9_0._btnchangeteam, true)
	arg_9_0:_updateHeroGroupName()
end

function var_0_0._updateHeroGroupName(arg_10_0)
	local var_10_0 = HeroGroupModel.instance:getPresetHeroGroupType()

	if not var_10_0 then
		return
	end

	local var_10_1 = arg_10_0:_getGroupSubId()
	local var_10_2 = HeroGroupPresetHeroGroupNameController.instance:getName(var_10_0, var_10_1)

	arg_10_0._txtherogroupname.text = var_10_2
end

function var_0_0._changeTeam(arg_11_0)
	local var_11_0 = HeroGroupModel.instance:getPresetHeroGroupType()

	HeroGroupPresetController.instance:openHeroGroupPresetTeamView({
		subId = arg_11_0:_getGroupSubId(),
		showType = HeroGroupPresetEnum.ShowType.Fight,
		heroGroupTypeList = {
			var_11_0
		}
	})
end

function var_0_0._getGroupSubId(arg_12_0)
	if HeroGroupModel.instance.heroGroupType == ModuleEnum.HeroGroupType.General then
		local var_12_0 = HeroGroupSnapshotModel.instance:getCurSnapshotId()

		return HeroGroupSnapshotModel.instance:getCurGroupId(var_12_0)
	end

	return HeroGroupModel.instance.curGroupSelectIndex
end

return var_0_0
