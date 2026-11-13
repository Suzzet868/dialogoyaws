(() => {
  const dialog = document.createElement('dialog');
  dialog.className = 'delete-confirm';
  dialog.setAttribute('aria-labelledby', 'delete-confirm-title');
  dialog.setAttribute('aria-describedby', 'delete-confirm-message');
  dialog.innerHTML = `
    <div class="delete-confirm__content">
      <h2 class="delete-confirm__title" id="delete-confirm-title">Confirmar eliminación</h2>
      <p class="delete-confirm__message" id="delete-confirm-message">
        ¿Seguro que deseas eliminar este registro?
      </p>
      <div class="delete-confirm__actions">
        <button class="delete-confirm__button delete-confirm__cancel" type="button">Cancelar</button>
        <button class="delete-confirm__button delete-confirm__accept" type="button">Sí, eliminar</button>
      </div>
    </div>
  `;
  document.body.append(dialog);

  const cancelButton = dialog.querySelector('.delete-confirm__cancel');
  const acceptButton = dialog.querySelector('.delete-confirm__accept');
  let pendingForm = null;
  let pendingSubmitter = null;
  let confirmed = false;

  document.addEventListener('submit', (event) => {
    const form = event.target;
    if (!(form instanceof HTMLFormElement) || !form.matches('[data-confirm-delete]')) {
      return;
    }

    if (form.dataset.confirmedDelete === 'true') {
      delete form.dataset.confirmedDelete;
      return;
    }

    event.preventDefault();
    pendingForm = form;
    pendingSubmitter = event.submitter;
    confirmed = false;
    acceptButton.focus();
    dialog.showModal();
  });

  cancelButton.addEventListener('click', () => dialog.close());
  dialog.addEventListener('click', (event) => {
    if (event.target === dialog) {
      dialog.close();
    }
  });
  dialog.addEventListener('close', () => {
    if (!pendingForm) {
      return;
    }

    const form = pendingForm;
    const submitter = pendingSubmitter;
    pendingForm = null;
    pendingSubmitter = null;
    if (!confirmed) {
      return;
    }

    confirmed = false;
    form.dataset.confirmedDelete = 'true';
    if (submitter && submitter.isConnected) {
      form.requestSubmit(submitter);
    } else {
      form.requestSubmit();
    }
  });
  acceptButton.addEventListener('click', () => {
    confirmed = true;
    dialog.close();
  });
})();
