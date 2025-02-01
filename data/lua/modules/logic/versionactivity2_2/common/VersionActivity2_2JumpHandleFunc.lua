module("modules.logic.versionactivity2_2.common.VersionActivity2_2JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity2_2JumpHandleFunc")

function slot0.jumpTo12201(slot0)
	VersionActivity2_2EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12202(slot0, slot1)
	VersionActivity2_2EnterController.instance:openVersionActivityEnterView(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12210(slot0, slot1)
	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12203(slot0, slot1)
	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		TianShiNaNaController.instance:openMainView()
	end, nil, slot1[2])
end

function slot0.jumpTo12204(slot0, slot1)
	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		LoperaController.instance:openLoperaMainView()
	end, nil, slot1[2])
end

return slot0
