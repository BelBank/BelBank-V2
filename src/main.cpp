#include <controller.h>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[]) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
	QGuiApplication app(argc, argv);

	QQmlApplicationEngine engine;
	Controller *controller = new Controller();
    app.setWindowIcon(QIcon(":/images/Logo_for_error.png"));
	engine.rootContext()->setContextProperty("Controller", controller);
	const QUrl url(QStringLiteral("qrc:/content/Main.qml"));
	QObject::connect(
			&engine,
			&QQmlApplicationEngine::objectCreated,
			&app,
			[url](QObject *obj, const QUrl &objUrl) {
				if (!obj && url == objUrl)
					QCoreApplication::exit(-1);
			},
			Qt::QueuedConnection);
	app.setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::Floor);

	engine.load(url);

	return app.exec();
}
