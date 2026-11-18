import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var showingImporter = false
    @State private var selectedIPAName: String?
    @State private var status = "Не подключён"
    @State private var certificateExpiry: Date?
    @State private var showingInfo = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                accountCard
                certificateCard
                ipaCard
                Spacer(minLength: 8)
                Text("iCert 7 • локальный менеджер подписи")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("iCert 7")
            .fileImporter(
                isPresented: $showingImporter,
                allowedContentTypes: [UTType(filenameExtension: "ipa") ?? .data],
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let urls):
                    guard let url = urls.first else { return }
                    selectedIPAName = url.lastPathComponent
                case .failure(let error):
                    status = "Ошибка импорта: \(error.localizedDescription)"
                }
            }
            .alert("Подписание IPA", isPresented: $showingInfo) {
                Button("Понятно", role: .cancel) { }
            } message: {
                Text("Модуль подписи пока не подключён. Для реальной подписи нужны действительные сертификат, приватный ключ и provisioning profile, выданные поддерживаемым Apple способом.")
            }
        }
    }

    private var accountCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Apple Developer Account", systemImage: "person.crop.circle")
                .font(.headline)
            HStack {
                Circle().fill(.orange).frame(width: 9, height: 9)
                Text(status).foregroundStyle(.secondary)
                Spacer()
            }
            Text("Пароль Apple ID и код 2FA не запрашиваются внутри приложения. Авторизация должна выполняться только через поддерживаемый Apple поток.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18))
    }

    private var certificateCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Development Certificate", systemImage: "checkmark.seal")
                .font(.headline)
            if let expiry = certificateExpiry {
                Text("Действителен до: \(expiry.formatted(date: .abbreviated, time: .shortened))")
                Text(expiry > .now ? "Сертификат ещё действителен" : "Срок действия истёк")
                    .foregroundStyle(expiry > .now ? .green : .red)
            } else {
                Text("Сертификат не добавлен")
                    .foregroundStyle(.secondary)
            }
            Text("Срок в 7 дней характерен для бесплатного provisioning-процесса, но фактические сроки определяются Apple.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18))
    }

    private var ipaCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("IPA-файл", systemImage: "doc.zipper")
                .font(.headline)
            Text(selectedIPAName ?? "Файл не выбран")
                .foregroundStyle(.secondary)
                .lineLimit(2)
            Button {
                showingImporter = true
            } label: {
                Label("Выбрать IPA из «Файлов»", systemImage: "folder")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            Button {
                showingInfo = true
            } label: {
                Label("Подписать IPA", systemImage: "signature")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .disabled(selectedIPAName == nil)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18))
    }
}
