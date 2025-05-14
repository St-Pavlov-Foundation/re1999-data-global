module("modules.logic.room.view.record.RoomCritterHandBookItem", package.seeall)

local var_0_0 = class("RoomCritterHandBookItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "empty")
	arg_1_0._goshow = gohelper.findChild(arg_1_0.viewGO, "show")
	arg_1_0._gofront = gohelper.findChild(arg_1_0.viewGO, "show/front")
	arg_1_0._goback = gohelper.findChild(arg_1_0.viewGO, "show/back")
	arg_1_0._simagecritter = gohelper.findChildSingleImage(arg_1_0.viewGO, "show/front/#simage_critter")
	arg_1_0._imagecardbg = gohelper.findChildImage(arg_1_0.viewGO, "show/front/#image_cardbg")
	arg_1_0._simageutm = gohelper.findChildSingleImage(arg_1_0.viewGO, "show/back/#simage_utm")
	arg_1_0._gobackbgicon = gohelper.findChild(arg_1_0.viewGO, "show/back/#simage_back/icon")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "show/#go_new")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click", AudioEnum.Room.play_ui_home_firmup_close)
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClickBtn, arg_2_0)
	arg_2_0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, arg_2_0.refreshBack, arg_2_0)
	arg_2_0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.reverseIcon, arg_2_0.reverse, arg_2_0)
	arg_2_0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.showMutate, arg_2_0.refreshMutate, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, arg_3_0.refreshBack, arg_3_0)
	arg_3_0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.reverseIcon, arg_3_0.reverse, arg_3_0)
	arg_3_0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.showMutate, arg_3_0.refreshMutate, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0.viewGO, true)
end

function var_0_0._onClickBtn(arg_5_0)
	arg_5_0._view:selectCell(arg_5_0._index, true)
	RoomHandBookModel.instance:setSelectMo(arg_5_0._mo)

	if arg_5_0._mo:checkNew() then
		CritterRpc.instance:sendMarkCritterBookNewReadRequest(arg_5_0._id)
	end

	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.onClickHandBookItem, arg_5_0._mo)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1
	arg_6_0._id = arg_6_1.id
	arg_6_0._config = arg_6_1:getConfig()

	local var_6_0 = arg_6_1:checkGotCritter()

	arg_6_0._isreverse = arg_6_1:checkIsReverse()

	gohelper.setActive(arg_6_0._goempty, not var_6_0)
	gohelper.setActive(arg_6_0._goshow, var_6_0)
	gohelper.setActive(arg_6_0._gonew, arg_6_1:checkNew())
	arg_6_0:refreshUI()

	if arg_6_0._isreverse ~= nil then
		if arg_6_0._isreverse then
			arg_6_0._animator:Play("empty", 0, 0)
		else
			arg_6_0._animator:Play("show", 0, 0)
		end
	end
end

function var_0_0.reverse(arg_7_0)
	arg_7_0._isreverse = arg_7_0._mo:checkIsReverse()

	if arg_7_0._isreverse then
		arg_7_0._animator:Play("to_empty", 0, 0)
	else
		arg_7_0._animator:Play("to_show", 0, 0)
	end
end

function var_0_0.refreshUI(arg_8_0)
	if arg_8_0._mo:checkShowSpeicalSkin() then
		local var_8_0 = lua_critter_skin.configDict[arg_8_0._config.mutateSkin]

		if var_8_0 then
			arg_8_0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(var_8_0.largeIcon), function()
				arg_8_0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, arg_8_0)
		end
	else
		arg_8_0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(arg_8_0._id), function()
			arg_8_0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, arg_8_0)
	end

	local var_8_1 = arg_8_0._mo:getBackGroundId() and true or false

	gohelper.setActive(arg_8_0._simageutm.gameObject, var_8_1)
	gohelper.setActive(arg_8_0._gobackbgicon, not var_8_1)

	if var_8_1 then
		arg_8_0._simageutm:LoadImage(ResUrl.getPropItemIcon(arg_8_0._mo:getBackGroundId()), function()
			arg_8_0._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, arg_8_0)
	end

	local var_8_2 = arg_8_0._config.catalogue
	local var_8_3 = lua_critter_catalogue.configDict[var_8_2].baseCard

	UISpriteSetMgr.instance:setCritterSprite(arg_8_0._imagecardbg, var_8_3)
end

function var_0_0.refreshBack(arg_12_0)
	local var_12_0 = arg_12_0._mo:getBackGroundId() and true or false

	gohelper.setActive(arg_12_0._simageutm.gameObject, var_12_0)
	gohelper.setActive(arg_12_0._gobackbgicon, not var_12_0)

	if var_12_0 then
		arg_12_0._simageutm:LoadImage(ResUrl.getPropItemIcon(arg_12_0._mo:getBackGroundId()), function()
			arg_12_0._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, arg_12_0)
	end
end

function var_0_0.refreshMutate(arg_14_0, arg_14_1)
	if arg_14_1.id ~= arg_14_0._mo.id then
		return
	end

	local var_14_0 = arg_14_1.UseSpecialSkin
	local var_14_1 = arg_14_0._mo:checkShowMutate()
	local var_14_2 = arg_14_0._mo:getConfig()

	if var_14_1 then
		if var_14_0 then
			local var_14_3 = lua_critter_skin.configDict[var_14_2.mutateSkin]

			if var_14_3 then
				arg_14_0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(var_14_3.largeIcon), function()
					arg_14_0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
				end, arg_14_0)
			end
		else
			arg_14_0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(var_14_2.id), function()
				arg_14_0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, arg_14_0)
		end
	end
end

function var_0_0.onSelect(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._goselect, arg_17_1)
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
