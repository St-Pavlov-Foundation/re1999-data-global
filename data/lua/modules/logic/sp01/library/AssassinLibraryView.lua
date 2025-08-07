module("modules.logic.sp01.library.AssassinLibraryView", package.seeall)

local var_0_0 = class("AssassinLibraryView", BaseView)
local var_0_1 = 1
local var_0_2 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_category")
	arg_1_0._gobanneritem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_category/Viewport/Content/#go_banneritem")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "root/#go_container")
	arg_1_0._gocontainer1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_container/#go_container1")
	arg_1_0._gocontainer2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_container/#go_container2")
	arg_1_0._btnclick = gohelper.getClick(arg_1_0._scrollcategory.gameObject)
	arg_1_0._gocamera = gohelper.findChild(arg_1_0.viewGO, "#go_camera")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnSelectLibLibType, arg_2_0._onSelectLibLibType, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._actItemTab) do
		if iter_4_1:tryClickSelf(arg_4_2, arg_4_0._eventCamera) then
			return
		end
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._actItemTab = arg_5_0:getUserDataTb_()

	gohelper.setActive(arg_5_0._gobanneritem, false)
	arg_5_0:initEventCamera()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:initActItemList()
	OdysseyStatHelper.instance:initViewStartTime()
	AudioMgr.instance:trigger(AudioEnum2_9.AssassinLibrary.play_ui_openlibrary)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_initParams()
end

function var_0_0.initEventCamera(arg_8_0)
	arg_8_0._eventCamera = arg_8_0._gocamera:GetComponent("Camera")

	local var_8_0 = AssassinEnum.LibraryCategoryCameraParams.cameraPos.x
	local var_8_1 = AssassinEnum.LibraryCategoryCameraParams.cameraPos.y
	local var_8_2 = AssassinEnum.LibraryCategoryCameraParams.cameraPos.z

	transformhelper.setPos(arg_8_0._gocamera.transform, var_8_0, var_8_1, var_8_2)
	transformhelper.setLocalScale(arg_8_0._gocamera.transform, 1, 1, 1)

	arg_8_0._eventCamera.orthographic = false
	arg_8_0._eventCamera.fieldOfView = AssassinEnum.LibraryCategoryCameraParams.perspFOV

	gohelper.setActive(arg_8_0._gocamera, false)
end

function var_0_0.initActItemList(arg_9_0)
	local var_9_0 = AssassinConfig.instance:getLibraryActIdList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = arg_9_0:_getOrCreateActItem(iter_9_1)

		var_9_1:setActId(iter_9_1)

		if iter_9_0 == var_0_1 then
			arg_9_0._defaultActId = iter_9_1
			arg_9_0._defaultLibType = var_9_1:getLibType(var_0_2)
		end
	end

	arg_9_0:_initParams()
end

function var_0_0._initParams(arg_10_0)
	local var_10_0 = arg_10_0.viewParam and arg_10_0.viewParam.actId
	local var_10_1 = arg_10_0.viewParam and arg_10_0.viewParam.libraryType

	arg_10_0._defaultActId = var_10_0 or arg_10_0._defaultActId
	arg_10_0._defaultLibType = var_10_1 or arg_10_0._defaultLibType

	arg_10_0:_foldOutSelectActItem()
	AssassinController.instance:dispatchEvent(AssassinEvent.OnSelectLibLibType, arg_10_0._defaultActId, arg_10_0._defaultLibType)
end

function var_0_0._foldOutSelectActItem(arg_11_0)
	local var_11_0 = arg_11_0._actItemTab and arg_11_0._actItemTab[arg_11_0._defaultActId]

	if not var_11_0 then
		return
	end

	var_11_0:setFold(true)
end

function var_0_0._getOrCreateActItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._actItemTab[arg_12_1]

	if not var_12_0 then
		local var_12_1 = gohelper.cloneInPlace(arg_12_0._gobanneritem, arg_12_1)

		var_12_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1, AssassinLibraryActCategoryItem)
		arg_12_0._actItemTab[arg_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0._onSelectLibLibType(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._actItemTab[arg_13_1]

	if not var_13_0 then
		logError(string.format("刺客信条资料库页签不存在 actId = %s, libType = %s", arg_13_1, arg_13_2))

		return
	end

	if arg_13_0._selectActItem then
		arg_13_0._selectActItem:onSelect(false)
	end

	var_13_0:onSelect(true, arg_13_2)

	arg_13_0._selectActItem = var_13_0

	AssassinLibraryModel.instance:switch(arg_13_1, arg_13_2)
	AssassinLibraryModel.instance:readTypeLibrarys(arg_13_1, arg_13_2)
	arg_13_0.viewContainer:switchLibType(arg_13_2)
end

function var_0_0.onClose(arg_14_0)
	OdysseyStatHelper.instance:sendOdysseyViewStayTime("AssassinLibraryView")
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
