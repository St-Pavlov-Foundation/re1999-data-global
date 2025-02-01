module("modules.common.others.openmultiview.OpenMultiView", package.seeall)

return {
	openView = function (slot0)
		slot1 = FlowSequence.New()

		for slot5, slot6 in ipairs(slot0) do
			slot1:addWork(OpenViewWork.New(slot6))
		end

		slot1:start()
	end
}
