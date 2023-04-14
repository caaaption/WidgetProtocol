open:
	open ./App/WidgetProtocol.xcodeproj

clean:
	rm -rf ./.swiftpm
	rm -rf ./.build
	xcodebuild clean -alltargets

PLATFORM_IOS = iOS Simulator,name=iPhone 13 Pro,OS=16.2

build:
	@xcodebuild build \
		-project App/WidgetProtocol.xcodeproj \
		-scheme WidgetProtocol
		-destination platform="$(PLATFORM_IOS)"
