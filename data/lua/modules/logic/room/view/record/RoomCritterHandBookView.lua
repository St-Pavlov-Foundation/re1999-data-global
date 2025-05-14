module("modules.logic.room.view.record.RoomCritterHandBookView", package.seeall)

local var_0_0 = class("RoomCritterHandBookView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#scroll_view")
	arg_1_0._btnleftreverse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_reverse")
	arg_1_0._goleftbtnback = gohelper.findChild(arg_1_0.viewGO, "left/#btn_reverse/back")
	arg_1_0._goleftbtnfront = gohelper.findChild(arg_1_0.viewGO, "left/#btn_reverse/front")
	arg_1_0._txtcollectionnum = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_collectionnum")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "right")
	arg_1_0._goshow = gohelper.findChild(arg_1_0.viewGO, "right/show")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "right/empty")
	arg_1_0._gobtnmutate = gohelper.findChild(arg_1_0.viewGO, "right/show/btnbg")
	arg_1_0._btnmutate = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/show/btnbg/#btn_mutate")
	arg_1_0._goshowmutate = gohelper.findChild(arg_1_0.viewGO, "right/show/btnbg/#btn_mutate/selected")
	arg_1_0._gohidemutate = gohelper.findChild(arg_1_0.viewGO, "right/show/btnbg/#btn_mutate/unselet")
	arg_1_0._btnyoung = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/show/btnbg/#btn_young")
	arg_1_0._goshowyoung = gohelper.findChild(arg_1_0.viewGO, "right/show/btnbg/#btn_young/selected")
	arg_1_0._gohideyoung = gohelper.findChild(arg_1_0.viewGO, "right/show/btnbg/#btn_young/unselect")
	arg_1_0._btnrightbtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/show/#btn_reverse")
	arg_1_0._goreversereddot = gohelper.findChild(arg_1_0.viewGO, "right/show/#btn_reverse/#go_reversereddot")
	arg_1_0._gofront = gohelper.findChild(arg_1_0.viewGO, "right/show/front")
	arg_1_0._goback = gohelper.findChild(arg_1_0.viewGO, "right/show/back")
	arg_1_0._imagecardbg = gohelper.findChildImage(arg_1_0.viewGO, "right/show/front/#image_cardbg")
	arg_1_0._simagecritter = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/show/front/#simage_critter")
	arg_1_0._gobackbgicon = gohelper.findChild(arg_1_0.viewGO, "right/show/back/#simage_back/icon")
	arg_1_0._simageutm = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/show/back/#simage_utm")
	arg_1_0._txtcrittername = gohelper.findChildText(arg_1_0.viewGO, "right/show/#txt_crittername")
	arg_1_0._txtcrittertype = gohelper.findChildText(arg_1_0.viewGO, "right/show/#txt_crittername/#txt_crittertype")
	arg_1_0._imagerelationship = gohelper.findChildImage(arg_1_0.viewGO, "right/legend/layout/scroll/#simage_critter")
	arg_1_0._txtreleationship = gohelper.findChildText(arg_1_0.viewGO, "right/legend/layout/scroll/Viewport/Content/relationship/#txt_releationship")
	arg_1_0._txtlegend = gohelper.findChildText(arg_1_0.viewGO, "right/legend/layout/scroll2/Viewport/Content/#txt_legend")
	arg_1_0._golengendempty = gohelper.findChild(arg_1_0.viewGO, "right/legend/#go_legendempty")
	arg_1_0._goscrolllegend = gohelper.findChild(arg_1_0.viewGO, "right/legend/layout")
	arg_1_0._goscrollrelationship = gohelper.findChild(arg_1_0.viewGO, "right/legend/layout/scroll")
	arg_1_0._goscroll2 = gohelper.findChild(arg_1_0.viewGO, "right/legend/layout/scroll2")
	arg_1_0._btnlog = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_log")
	arg_1_0._gologreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_log/reddot")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_taskreddot")
	arg_1_0._rightanimator = arg_1_0._goright:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnanimator = arg_1_0._btnleftreverse.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gofoods = {}
	arg_1_0._mo = nil
	arg_1_0._scrollview = arg_1_0.viewContainer:getHandBookScrollView()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnleftreverse:AddClickListener(arg_2_0._btnleftreverseOnClick, arg_2_0)
	arg_2_0._btnrightbtn:AddClickListener(arg_2_0._btnrightbtnOnClick, arg_2_0)
	arg_2_0._btnmutate:AddClickListener(arg_2_0._btnmutateOnClick, arg_2_0)
	arg_2_0._btnyoung:AddClickListener(arg_2_0._btnyoungOnClick, arg_2_0)
	arg_2_0._btnlog:AddClickListener(arg_2_0._btnlogOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.onClickHandBookItem, arg_2_0.updateView, arg_2_0)
	arg_2_0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, arg_2_0.refreshBack, arg_2_0)
	arg_2_0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.showMutate, arg_2_0.refreshMutate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnleftreverse:RemoveClickListener()
	arg_3_0._btnrightbtn:RemoveClickListener()
	arg_3_0._btnmutate:RemoveClickListener()
	arg_3_0._btnyoung:RemoveClickListener()
	arg_3_0._btnlog:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.onClickHandBookItem, arg_3_0.updateView, arg_3_0)
	arg_3_0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, arg_3_0.refreshBack, arg_3_0)
	arg_3_0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.showMutate, arg_3_0.refreshMutate, arg_3_0)
end

function var_0_0._btnlogOnClick(arg_4_0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.HandBook2Log,
		view = RoomRecordEnum.View.Log
	})
end

function var_0_0._btntaskOnClick(arg_5_0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.HandBook2Task,
		view = RoomRecordEnum.View.Task
	})
end

function var_0_0._btnleftreverseOnClick(arg_6_0)
	RoomHandBookModel.instance:setScrollReverse()
	arg_6_0:reverseIcon()

	arg_6_0._isreverse = RoomHandBookModel.instance:getReverse()

	gohelper.setActive(arg_6_0._goleftbtnback, arg_6_0._isreverse)
	gohelper.setActive(arg_6_0._goleftbtnfront, not arg_6_0._isreverse)

	if arg_6_0._isreverse then
		arg_6_0._btnanimator:Play("to_front", 0, 0)
		TaskDispatcher.runDelay(arg_6_0.reverseAnim, arg_6_0, RoomRecordEnum.AnimTime)
	else
		arg_6_0._btnanimator:Play("to_back", 0, 0)
		TaskDispatcher.runDelay(arg_6_0.reverseAnim, arg_6_0, RoomRecordEnum.AnimTime)
	end
end

function var_0_0.reverseAnim(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.reverseAnim, arg_7_0)

	if arg_7_0._isreverse then
		arg_7_0._btnanimator:Play("to_back", 0, 0)
	else
		arg_7_0._btnanimator:Play("to_front", 0, 0)
	end
end

function var_0_0._btnrightbtnOnClick(arg_8_0)
	ViewMgr.instance:openView(ViewName.RoomCritterHandBookBackView)
	RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.Newstriker, false)
end

function var_0_0._btnmutateOnClick(arg_9_0)
	local var_9_0 = RoomHandBookModel.instance:getSelectMo()

	CritterRpc.instance:sendSetCritterBookUseSpecialSkinRequest(var_9_0.id, true)
end

function var_0_0._btnyoungOnClick(arg_10_0)
	local var_10_0 = RoomHandBookModel.instance:getSelectMo()

	CritterRpc.instance:sendSetCritterBookUseSpecialSkinRequest(var_10_0.id, false)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._goscroll2ArrowGo = gohelper.findChild(arg_11_0._goscroll2, "gameobject")
	arg_11_0._goscroll2ArrowTrans = arg_11_0._goscroll2ArrowGo.transform
	arg_11_0._goscroll2ArrowDefaultY = recthelper.getAnchorY(arg_11_0._goscroll2ArrowTrans)

	for iter_11_0 = 1, 3 do
		local var_11_0 = arg_11_0:getUserDataTb_()

		var_11_0.go = gohelper.findChild(arg_11_0.viewGO, "right/show/food/item" .. iter_11_0)
		var_11_0.simage = gohelper.findChildSingleImage(var_11_0.go, "#simage_icon")

		gohelper.setActive(var_11_0.go, false)
		table.insert(arg_11_0._gofoods, var_11_0)
	end
end

function var_0_0.updateView(arg_12_0, arg_12_1)
	if arg_12_0._mo ~= arg_12_1 then
		arg_12_0._rightanimator:Play("switch", 0, 0)
	end

	arg_12_0._mo = arg_12_1 and arg_12_1 or RoomHandBookModel.instance:getSelectMo()
	arg_12_0._isSpecial = arg_12_0._mo.UseSpecialSkin

	local var_12_0 = arg_12_0._mo:checkGotCritter()
	local var_12_1 = arg_12_0._mo:getConfig()

	gohelper.setActive(arg_12_0._goshow, var_12_0)
	gohelper.setActive(arg_12_0._goempty, not var_12_0)

	if var_12_0 then
		arg_12_0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(var_12_1.id), function()
			arg_12_0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, arg_12_0)
	end

	arg_12_0._txtcrittername.text = var_12_0 and var_12_1.name or ""

	local var_12_2 = var_12_1.catalogue
	local var_12_3 = lua_critter_catalogue.configDict[var_12_2].name
	local var_12_4 = lua_critter_catalogue.configDict[var_12_2].baseCard

	UISpriteSetMgr.instance:setCritterSprite(arg_12_0._imagecardbg, var_12_4)

	arg_12_0._txtcrittertype.text = var_12_0 and var_12_3 or ""

	local var_12_5 = arg_12_0._mo:checkShowMutate()

	gohelper.setActive(arg_12_0._gobtnmutate, var_12_5)

	if var_12_5 then
		gohelper.setActive(arg_12_0._btnmutate.gameObject, not arg_12_0._mo:checkShowSpeicalSkin())
		gohelper.setActive(arg_12_0._btnyoung.gameObject, arg_12_0._mo:checkShowSpeicalSkin())
		gohelper.setActive(arg_12_0._goshowmutate, not arg_12_0._mo:checkShowSpeicalSkin())
		gohelper.setActive(arg_12_0._gohidemutate, arg_12_0._mo:checkShowSpeicalSkin())
		gohelper.setActive(arg_12_0._goshowyoung, arg_12_0._mo:checkShowSpeicalSkin())
		gohelper.setActive(arg_12_0._gohideyoung, not arg_12_0._mo:checkShowSpeicalSkin())
	end

	if arg_12_0._mo:checkShowSpeicalSkin() then
		local var_12_6 = lua_critter_skin.configDict[var_12_1.mutateSkin]

		if var_12_6 then
			arg_12_0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(var_12_6.largeIcon), function()
				arg_12_0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, arg_12_0)
		end
	else
		arg_12_0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(var_12_1.id), function()
			arg_12_0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, arg_12_0)
	end

	arg_12_0:refreshLikeFood(arg_12_0._mo)
	arg_12_0:refreshLegend(arg_12_0._mo)

	local var_12_7 = arg_12_0._mo:getBackGroundId()
	local var_12_8 = var_12_7 and var_12_7 ~= 0

	gohelper.setActive(arg_12_0._simageutm.gameObject, var_12_8)
	gohelper.setActive(arg_12_0._gobackbgicon, not var_12_8)

	if var_12_7 and var_12_7 ~= 0 then
		arg_12_0._simageutm:LoadImage(ResUrl.getPropItemIcon(arg_12_0._mo:getBackGroundId()), function()
			arg_12_0._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
		end)
	end

	local var_12_9 = RoomHandBookModel.instance:getCount()
	local var_12_10 = CritterConfig.instance:getCritterCount()

	arg_12_0._txtcollectionnum.text = string.format("<color=#cd5200>%s</color>/%s", var_12_9, var_12_10)
end

function var_0_0.refreshLikeFood(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:getConfig()

	if not var_17_0 or string.nilorempty(var_17_0.foodLike) or not arg_17_1:checkGotCritter() then
		for iter_17_0 = 1, #arg_17_0._gofoods do
			gohelper.setActive(arg_17_0._gofoods[iter_17_0].go, false)
		end

		return
	end

	local var_17_1 = GameUtil.splitString2(var_17_0.foodLike)
	local var_17_2 = {}

	for iter_17_1, iter_17_2 in ipairs(var_17_1) do
		local var_17_3 = iter_17_2[1]

		table.insert(var_17_2, var_17_3)
	end

	for iter_17_3 = 1, #var_17_2 do
		local var_17_4 = arg_17_0._gofoods[iter_17_3]
		local var_17_5 = ItemConfig.instance:getItemCo(tonumber(var_17_2[iter_17_3])).icon

		var_17_4.simage:LoadImage(ResUrl.getPropItemIcon(var_17_5))
		gohelper.setActive(var_17_4.go, true)
	end

	for iter_17_4 = #arg_17_0._gofoods, #var_17_2 + 1, -1 do
		gohelper.setActive(arg_17_0._gofoods[iter_17_4].go, false)
	end
end

function var_0_0.refreshLegend(arg_18_0, arg_18_1)
	local var_18_0 = 446
	local var_18_1 = 264
	local var_18_2 = arg_18_1:getConfig()
	local var_18_3 = true

	if not var_18_2 or not arg_18_1:checkGotCritter() then
		var_18_3 = false
	end

	gohelper.setActive(arg_18_0._golengendempty, not var_18_3)
	gohelper.setActive(arg_18_0._goscrolllegend, var_18_3)

	if string.nilorempty(var_18_2.line) then
		gohelper.setActive(arg_18_0._goscrollrelationship.gameObject, false)
		recthelper.setHeight(arg_18_0._goscroll2.transform, var_18_0)
		recthelper.setAnchorY(arg_18_0._goscroll2ArrowTrans, -137)
	else
		gohelper.setActive(arg_18_0._goscrollrelationship.gameObject, true)

		arg_18_0._txtreleationship.text = var_18_2.line

		recthelper.setHeight(arg_18_0._goscroll2.transform, var_18_1)
		recthelper.setAnchorY(arg_18_0._goscroll2ArrowTrans, arg_18_0._goscroll2ArrowDefaultY)
	end

	arg_18_0._txtlegend.text = var_18_2.story

	if not string.nilorempty(var_18_2.relation) then
		local var_18_4 = "room_handbook_relationship" .. var_18_2.relation

		UISpriteSetMgr.instance:setCritterSprite(arg_18_0._imagerelationship, var_18_4)
	end
end

function var_0_0.reverseIcon(arg_19_0)
	local var_19_0 = RoomHandBookModel.instance:getReverse()
	local var_19_1 = RoomHandBookModel.instance:getSelectMo()

	gohelper.setActive(arg_19_0._gofront, not var_19_0)
	gohelper.setActive(arg_19_0._goback, var_19_0)
	gohelper.setActive(arg_19_0._goleftbtnback, not var_19_0)
	gohelper.setActive(arg_19_0._goleftbtnfront, var_19_0)

	if var_19_0 then
		local var_19_2 = var_19_1:getBackGroundId() and true or false

		gohelper.setActive(arg_19_0._simageutm.gameObject, var_19_2)

		if var_19_2 then
			arg_19_0._simageutm:LoadImage(ResUrl.getPropItemIcon(var_19_1:getBackGroundId()), function()
				arg_19_0._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, arg_19_0)
		end

		gohelper.setActive(arg_19_0._gobackbgicon, not var_19_2)
	end
end

function var_0_0.refreshBack(arg_21_0)
	local var_21_0 = RoomHandBookModel.instance:getReverse()
	local var_21_1 = RoomHandBookModel.instance:getSelectMo()

	if var_21_0 then
		local var_21_2 = var_21_1:getBackGroundId() and true or false

		gohelper.setActive(arg_21_0._simageutm.gameObject, var_21_2)

		if var_21_2 then
			arg_21_0._simageutm:LoadImage(ResUrl.getPropItemIcon(var_21_1:getBackGroundId()), function()
				arg_21_0._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, arg_21_0)
		end

		gohelper.setActive(arg_21_0._gobackbgicon, not var_21_2)
	end
end

function var_0_0.refreshMutate(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.UseSpecialSkin
	local var_23_1 = arg_23_0._mo:checkShowMutate()
	local var_23_2 = arg_23_0._mo:getConfig()

	if var_23_1 then
		gohelper.setActive(arg_23_0._btnmutate.gameObject, not arg_23_0._mo:checkShowSpeicalSkin())
		gohelper.setActive(arg_23_0._btnyoung.gameObject, arg_23_0._mo:checkShowSpeicalSkin())
		gohelper.setActive(arg_23_0._goshowmutate, not arg_23_0._mo:checkShowSpeicalSkin())
		gohelper.setActive(arg_23_0._gohidemutate, arg_23_0._mo:checkShowSpeicalSkin())
		gohelper.setActive(arg_23_0._goshowyoung, arg_23_0._mo:checkShowSpeicalSkin())
		gohelper.setActive(arg_23_0._gohideyoung, not arg_23_0._mo:checkShowSpeicalSkin())
	end

	if var_23_0 then
		local var_23_3 = lua_critter_skin.configDict[var_23_2.mutateSkin]

		if var_23_3 then
			arg_23_0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(var_23_3.largeIcon), function()
				arg_23_0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, arg_23_0)
		end
	else
		arg_23_0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(var_23_2.id), function()
			arg_23_0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, arg_23_0)
	end
end

function var_0_0.onOpen(arg_26_0)
	RoomHandBookListModel.instance:init()
	arg_26_0._scrollview:selectCell(1, true)
	gohelper.setActive(arg_26_0._gofront, true)
	gohelper.setActive(arg_26_0._goback, false)
	arg_26_0:updateView()
	RedDotController.instance:addRedDot(arg_26_0._gotaskreddot, RedDotEnum.DotNode.TradeTask)
	RedDotController.instance:addRedDot(arg_26_0._gologreddot, RedDotEnum.DotNode.CritterLog)
	RedDotController.instance:addRedDot(arg_26_0._goreversereddot, RedDotEnum.DotNode.Newstriker)
end

function var_0_0.onClose(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0.reverseAnim, arg_27_0)
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

return var_0_0
